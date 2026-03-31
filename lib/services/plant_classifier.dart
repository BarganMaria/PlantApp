import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../data/plant_info.dart';

class PlantPrediction {
  final String label;
  final double confidence;
  final PlantInfo? info;

  const PlantPrediction({
    required this.label,
    required this.confidence,
    required this.info,
  });

  String get displayName => info?.nameRo ?? _titleFromLabel(label);
  String get latinName => info?.latin ?? _latinFromLabel(label);
  String get status => info?.status ?? 'LC';
}

class PlantClassifier {
  PlantClassifier._();

  static final PlantClassifier instance = PlantClassifier._();

  Interpreter? _interpreter;
  List<String>? _labels;
  Completer<void>? _loadingCompleter;
  bool _loggedTensorInfo = false;

  Future<void> load() async {
    if (_interpreter != null && _labels != null) return;
    if (_loadingCompleter != null) return _loadingCompleter!.future;

    _loadingCompleter = Completer<void>();
    try {
      final interpreter = await Interpreter.fromAsset('assets/tflite_model/model.tflite');
      final labelsRaw = await rootBundle.loadString('assets/tflite_model/labels.txt');
      _interpreter = interpreter;
      _labels = labelsRaw
          .split('\n')
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .toList();
      _loadingCompleter?.complete();
    } catch (e) {
      _loadingCompleter?.completeError(e);
      rethrow;
    } finally {
      _loadingCompleter = null;
    }
  }

  Future<PlantPrediction> classify(String imagePath) async {
    final predictions = await classifyTopK(imagePath, k: 1);
    return predictions.first;
  }

  Future<List<PlantPrediction>> classifyTopK(String imagePath, {int k = 3}) async {
    await load();
    final interpreter = _interpreter;
    final labels = _labels;
    if (interpreter == null || labels == null) {
      throw StateError('Modelul nu este incarcat.');
    }

    final inputTensor = interpreter.getInputTensor(0);
    final outputTensor = interpreter.getOutputTensor(0);
    if (!_loggedTensorInfo) {
      _loggedTensorInfo = true;
      debugPrint(
        'Plant model input: type=${inputTensor.type} shape=${inputTensor.shape} '
        'scale=${inputTensor.params.scale} zeroPoint=${inputTensor.params.zeroPoint}',
      );
      debugPrint(
        'Plant model output: type=${outputTensor.type} shape=${outputTensor.shape} '
        'scale=${outputTensor.params.scale} zeroPoint=${outputTensor.params.zeroPoint}',
      );
    }

    final inputShape = inputTensor.shape;
    if (inputShape.length != 4) {
      throw StateError('Forma inputului nu este suportata: $inputShape');
    }

    final height = inputShape[1];
    final width = inputShape[2];
    final channels = inputShape[3];

    final bytes = await File(imagePath).readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw StateError('Nu pot citi imaginea selectata.');
    }

    final resized = _prepareImage(image, width, height);
    final output = _buildOutput(outputTensor);
    final input = _buildInput(resized, height, width, channels, inputTensor);
    interpreter.run(input, output);

    var rawScores = _flattenOutput(output, outputTensor);
    var scores = _normalizeScores(rawScores);
    _logOutputStats('baseline', rawScores, scores);

    if (inputTensor.type == TensorType.float32 && _looksFlat(scores)) {
      final attempts = <_FloatAttempt>[
        _FloatAttempt(_FloatNorm.minusOneToOne, _ChannelOrder.rgb, '[-1,1] rgb'),
        _FloatAttempt(_FloatNorm.imagenet, _ChannelOrder.rgb, 'imagenet rgb'),
        _FloatAttempt(_FloatNorm.imagenet, _ChannelOrder.bgr, 'imagenet bgr'),
        _FloatAttempt(_FloatNorm.raw255, _ChannelOrder.rgb, 'raw255 rgb'),
        _FloatAttempt(_FloatNorm.raw255, _ChannelOrder.bgr, 'raw255 bgr'),
        _FloatAttempt(_FloatNorm.zeroToOne, _ChannelOrder.bgr, '[0,1] bgr'),
      ];

      var bestScores = scores;
      var bestLabel = 'baseline';
      var bestMax = scores.reduce(max);

      for (final attempt in attempts) {
        final altInput =
            _buildFloatInput(resized, height, width, channels, attempt.norm, attempt.order);
        interpreter.run(altInput, output);
        final altRaw = _flattenOutput(output, outputTensor);
        final altScores = _normalizeScores(altRaw);
        _logOutputStats(attempt.label, altRaw, altScores);
        final altMax = altScores.reduce(max);
        if (!_looksFlat(altScores) && altMax >= bestMax) {
          bestScores = altScores;
          bestMax = altMax;
          bestLabel = attempt.label;
          break;
        }
        if (altMax > bestMax + 0.05) {
          bestScores = altScores;
          bestMax = altMax;
          bestLabel = attempt.label;
        }
      }

      if (!identical(bestScores, scores)) {
        scores = bestScores;
        debugPrint('Plant model: retried float normalization $bestLabel.');
      } else {
        debugPrint('Plant model: retries did not improve output.');
      }
    }
    if (scores.isEmpty) {
      throw StateError('Iesirea modelului este goala.');
    }

    final safeCount = min(scores.length, labels.length);
    final entries = List.generate(safeCount, (i) => MapEntry(i, scores[i]))
      ..sort((a, b) => b.value.compareTo(a.value));

    final takeCount = min(k, entries.length);
    final results = <PlantPrediction>[];
    for (var i = 0; i < takeCount; i++) {
      final index = entries[i].key;
      final label = labels[index];
      final info = getPlantInfo(label);
      results.add(
        PlantPrediction(
          label: label,
          confidence: entries[i].value,
          info: info,
        ),
      );
    }

    return results;
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels = null;
  }
}

Object _buildInput(img.Image image, int height, int width, int channels, Tensor tensor) {
  final type = tensor.type;
  final quant = tensor.params;

  if (type == TensorType.uint8 || type == TensorType.int8) {
    return _buildIntInput(image, height, width, channels, quant, type == TensorType.int8);
  }

  return _buildFloatInput(image, height, width, channels, _FloatNorm.zeroToOne, _ChannelOrder.rgb);
}

class _FloatAttempt {
  final _FloatNorm norm;
  final _ChannelOrder order;
  final String label;

  const _FloatAttempt(this.norm, this.order, this.label);
}

Object _buildFloatInput(
  img.Image image,
  int height,
  int width,
  int channels,
  _FloatNorm norm,
  _ChannelOrder order,
) {
  final input = List.generate(
    1,
    (_) => List.generate(
      height,
      (_) => List.generate(
        width,
        (_) => List.filled(channels, 0.0),
      ),
    ),
  );

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r;
      final g = pixel.g;
      final b = pixel.b;

      if (channels == 1) {
        final value = (r + g + b) / 3.0;
        input[0][y][x][0] = _applyFloatNorm(value, norm, 0, order);
      } else {
        final values = order == _ChannelOrder.rgb
            ? [r.toDouble(), g.toDouble(), b.toDouble()]
            : [b.toDouble(), g.toDouble(), r.toDouble()];
        input[0][y][x][0] = _applyFloatNorm(values[0], norm, 0, order);
        input[0][y][x][1] = _applyFloatNorm(values[1], norm, 1, order);
        input[0][y][x][2] = _applyFloatNorm(values[2], norm, 2, order);
      }
    }
  }

  return input;
}

Object _buildIntInput(
  img.Image image,
  int height,
  int width,
  int channels,
  QuantizationParams quant,
  bool isSigned,
) {
  final input = List.generate(
    1,
    (_) => List.generate(
      height,
      (_) => List.generate(
        width,
        (_) => List.filled(channels, 0),
      ),
    ),
  );

  final scale = quant.scale == 0 ? 1.0 : quant.scale;
  final zeroPoint = quant.zeroPoint;
  final useRaw255 = !isSigned && zeroPoint == 0 && scale >= 0.5;

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r;
      final g = pixel.g;
      final b = pixel.b;

      final values = channels == 1
          ? [(r + g + b) / 3]
          : [r.toDouble(), g.toDouble(), b.toDouble()];

      for (var c = 0; c < channels; c++) {
        final realValue = useRaw255 ? values[c] : values[c] / 255.0;
        var quantized = (realValue / scale + zeroPoint).round();
        if (isSigned) {
          quantized = quantized.clamp(-128, 127);
        } else {
          quantized = quantized.clamp(0, 255);
        }
        input[0][y][x][c] = quantized;
      }
    }
  }

  return input;
}

Object _buildOutput(Tensor tensor) {
  final shape = tensor.shape;
  final type = tensor.type;
  final fillValue = (type == TensorType.uint8 || type == TensorType.int8) ? 0 : 0.0;

  if (shape.isEmpty) {
    return [];
  }

  List<dynamic> buildLevel(int dimension) {
    final size = shape[dimension];
    if (dimension == shape.length - 1) {
      return List.filled(size, fillValue);
    }
    return List.generate(size, (_) => buildLevel(dimension + 1));
  }

  return buildLevel(0);
}

enum _FloatNorm { zeroToOne, minusOneToOne, imagenet, raw255 }
enum _ChannelOrder { rgb, bgr }

double _applyFloatNorm(double value, _FloatNorm norm, int channelIndex, _ChannelOrder order) {
  final normalized = value / 255.0;
  if (norm == _FloatNorm.raw255) {
    return value;
  }
  if (norm == _FloatNorm.minusOneToOne) {
    return normalized * 2.0 - 1.0;
  }
  if (norm == _FloatNorm.imagenet) {
    const meanRgb = [0.485, 0.456, 0.406];
    const stdRgb = [0.229, 0.224, 0.225];
    final mean = order == _ChannelOrder.rgb ? meanRgb : [meanRgb[2], meanRgb[1], meanRgb[0]];
    final std = order == _ChannelOrder.rgb ? stdRgb : [stdRgb[2], stdRgb[1], stdRgb[0]];
    return (normalized - mean[channelIndex]) / std[channelIndex];
  }
  return normalized;
}

img.Image _prepareImage(img.Image source, int targetWidth, int targetHeight) {
  // Match training: Resize shorter side to 256, then center-crop 224.
  const int resizeShort = 256;
  final width = source.width;
  final height = source.height;
  if (width == 0 || height == 0) {
    return img.copyResize(source, width: targetWidth, height: targetHeight);
  }

  final bool widthIsShorter = width < height;
  final int newWidth = widthIsShorter
      ? resizeShort
      : (width * resizeShort / height).round();
  final int newHeight = widthIsShorter
      ? (height * resizeShort / width).round()
      : resizeShort;

  final resized = img.copyResize(source, width: newWidth, height: newHeight);

  final cropWidth = targetWidth.clamp(1, resized.width);
  final cropHeight = targetHeight.clamp(1, resized.height);
  final x = ((resized.width - cropWidth) / 2).round();
  final y = ((resized.height - cropHeight) / 2).round();

  return img.copyCrop(resized, x: x, y: y, width: cropWidth, height: cropHeight);
}

List<double> _flattenOutput(Object output, Tensor tensor) {
  final List<double> result = [];
  final quant = tensor.params;
  final isQuantized = tensor.type == TensorType.uint8 || tensor.type == TensorType.int8;

  void walk(dynamic value) {
    if (value is List) {
      for (final item in value) {
        walk(item);
      }
    } else if (value is num) {
      if (isQuantized) {
        final scale = quant.scale == 0 ? 1.0 : quant.scale;
        result.add(scale * (value.toDouble() - quant.zeroPoint));
      } else {
        result.add(value.toDouble());
      }
    }
  }

  walk(output);
  return result;
}

List<double> _normalizeScores(List<double> scores) {
  if (scores.isEmpty) return scores;

  final maxScore = scores.reduce(max);
  final sum = scores.fold<double>(0.0, (acc, v) => acc + v);

  final looksLikeProbabilities = maxScore <= 1.0 && sum > 0.5 && sum < 1.5;
  if (looksLikeProbabilities) {
    return scores;
  }

  final expScores = scores.map((v) => exp(v - maxScore)).toList();
  final expSum = expScores.fold<double>(0.0, (acc, v) => acc + v);
  if (expSum == 0) return scores;

  return expScores.map((v) => v / expSum).toList();
}

bool _looksFlat(List<double> scores) {
  if (scores.isEmpty) return true;
  final maxScore = scores.reduce(max);
  final minScore = scores.reduce(min);
  if ((maxScore - minScore).abs() < 0.01) return true;
  final mean = scores.fold<double>(0.0, (acc, v) => acc + v) / scores.length;
  final variance =
      scores.fold<double>(0.0, (acc, v) => acc + (v - mean) * (v - mean)) /
      scores.length;
  return maxScore < 0.2 && variance < 0.0005;
}

void _logOutputStats(String tag, List<double> raw, List<double> scores) {
  if (!kDebugMode) return;
  if (raw.isEmpty) return;
  double minRaw = raw.first;
  double maxRaw = raw.first;
  for (final v in raw) {
    if (v < minRaw) minRaw = v;
    if (v > maxRaw) maxRaw = v;
  }
  final top = scores.isNotEmpty ? scores.reduce(max) : 0.0;
  debugPrint('Plant model [$tag]: raw min=$minRaw max=$maxRaw top=$top');
}

String _titleFromLabel(String label) {
  final words = label.split('_');
  return words
      .map((word) => word.isEmpty ? word : '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');
}

String _latinFromLabel(String label) {
  final words = label.split('_');
  if (words.length < 2) return _titleFromLabel(label);
  final genus = words[0];
  final species = words.sublist(1).join(' ');
  return '${genus[0].toUpperCase()}${genus.substring(1)} $species';
}

