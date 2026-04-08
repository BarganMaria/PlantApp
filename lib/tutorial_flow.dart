import 'package:flutter/material.dart';
import 'home_shell.dart';

class TutorialFlow extends StatefulWidget {
  const TutorialFlow({super.key});

  @override
  State<TutorialFlow> createState() => _TutorialFlowState();
}

class _TutorialFlowState extends State<TutorialFlow> {
  static const _accent = Color(0xFFC57AE6);
  static const _accentDark = Color(0xFFA85FD0);
  static const _textMuted = Color(0xFF707070);
  static const _dotInactive = Color(0xFFE3DDEB);

  final _controller = PageController();

  final List<_SlideData> _slides = const [
    _SlideData(
      title: 'ILUMINATIE BUNA',
      description:
          'Foloseste lumina naturala, asigura-te ca frunzele si culorile plantei se vad clar',
      imageAsset: 'assets/tutorial_image_1.png',
      buttonLabel: 'Next',
    ),
    _SlideData(
      title: 'CAPTUREAZA\nTRASATURILE CHEIE',
      description:
          'Fotografiaza clar frunzele, florile, tulpina sau alte elemente distinctive care pot ajuta la identificare precisa',
      imageAsset: 'assets/tutorial_image_2.png',
      buttonLabel: 'Next',
    ),
    _SlideData(
      title: 'AFLA MAI MULTE DESPRE\nPLANTE!',
      description:
          'Descopera catalogul de flora a Moldovei si speciile rare care merita protejate!',
      imageAsset: 'assets/tutorial_image_3.png',
      buttonLabel: 'Start',
    ),
  ];

  int _index = 0;

  bool get _isLast => _index == _slides.length - 1;

  void _onNextPressed() {
    if (_isLast) {
      _finish();
      return;
    }

    _controller.animateToPage(
      _index + 1,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  void _finish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_index];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (value) => setState(() => _index = value),
                itemBuilder: (context, i) => _SlideView(
                  data: _slides[i],
                  isLast: i == _slides.length - 1,
                ),
              ),
            ),
            _DotsIndicator(
              activeIndex: _index,
              count: _slides.length,
              activeColor: _accent,
              inactiveColor: _dotInactive,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(26, _isLast ? 0 : 2, 26, 26),
              child: Row(
                children: [
                  if (!_isLast)
                    TextButton(
                      onPressed: _finish,
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: _textMuted, fontSize: 26),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  if (!_isLast) const Spacer(),
                  Expanded(
                    flex: _isLast ? 1 : 0,
                    child: _PrimaryPillButton(
                      label: slide.buttonLabel,
                      onTap: _onNextPressed,
                      accent: _accent,
                      accentDark: _accentDark,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String description;
  final String imageAsset;
  final String buttonLabel;

  const _SlideData({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.buttonLabel,
  });
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.data, required this.isLast});

  final _SlideData data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Image.asset(
                data.imageAsset,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isLast ? const Color(0xFFB53AE6) : const Color(0xFF191919),
              fontSize: isLast ? 42 : 34,
              height: 1.05,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 18,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    required this.activeIndex,
    required this.count,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int activeIndex;
  final int count;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: i == activeIndex ? activeColor : inactiveColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _PrimaryPillButton extends StatelessWidget {
  const _PrimaryPillButton({
    required this.label,
    required this.onTap,
    required this.accent,
    required this.accentDark,
    required this.textColor,
  });

  final String label;
  final VoidCallback onTap;
  final Color accent;
  final Color accentDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accent, accentDark]),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x339A62C6),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



