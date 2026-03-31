import 'package:flutter/material.dart';

class PlantInfo {
  final String label;
  final String nameRo;
  final String latin;
  final String status;

  const PlantInfo({
    required this.label,
    required this.nameRo,
    required this.latin,
    required this.status,
  });
}

class PlantStatusInfo {
  final String code;
  final String labelRo;
  final Color color;

  const PlantStatusInfo({
    required this.code,
    required this.labelRo,
    required this.color,
  });
}

const Map<String, PlantStatusInfo> plantStatusInfo = {
  'EX': PlantStatusInfo(code: 'EX', labelRo: 'Disparut', color: Color(0xFF000000)),
  'CR': PlantStatusInfo(code: 'CR', labelRo: 'Pericol critic', color: Color(0xFFCC0000)),
  'EN': PlantStatusInfo(code: 'EN', labelRo: 'Periclitat', color: Color(0xFFFF4500)),
  'VU': PlantStatusInfo(code: 'VU', labelRo: 'Vulnerabil', color: Color(0xFFFF8C00)),
  'NT': PlantStatusInfo(code: 'NT', labelRo: 'Aproape amenintat', color: Color(0xFFFFD700)),
  'LC': PlantStatusInfo(code: 'LC', labelRo: 'Specie obisnuita', color: Color(0xFF228B22)),
};

const Map<String, PlantInfo> plantInfoByLabel = {
  'aconitum_lasiostomum': PlantInfo(
    label: 'aconitum_lasiostomum',
    nameRo: 'Omagul galben',
    latin: 'Aconitum lasiostomum',
    status: 'CR',
  ),
  'anemone_sylvestris': PlantInfo(
    label: 'anemone_sylvestris',
    nameRo: 'Anemona de padure',
    latin: 'Anemone sylvestris',
    status: 'VU',
  ),
  'campanula_sibirica': PlantInfo(
    label: 'campanula_sibirica',
    nameRo: 'Clopotel siberian',
    latin: 'Campanula sibirica',
    status: 'EN',
  ),
  'centaurea_cyanus': PlantInfo(
    label: 'centaurea_cyanus',
    nameRo: 'Albastrele',
    latin: 'Centaurea cyanus',
    status: 'LC',
  ),
  'chrysanthemum_x_morifolium': PlantInfo(
    label: 'chrysanthemum_x_morifolium',
    nameRo: 'Crizantema',
    latin: 'Chrysanthemum x morifolium',
    status: 'LC',
  ),
  'colchicum_autumnale': PlantInfo(
    label: 'colchicum_autumnale',
    nameRo: 'Brandusa de toamna',
    latin: 'Colchicum autumnale',
    status: 'NT',
  ),
  'convallaria_majalis': PlantInfo(
    label: 'convallaria_majalis',
    nameRo: 'Lacramioare',
    latin: 'Convallaria majalis',
    status: 'EN',
  ),
  'dianthus_carthusianorum': PlantInfo(
    label: 'dianthus_carthusianorum',
    nameRo: 'Garoafa de stepa',
    latin: 'Dianthus carthusianorum',
    status: 'NT',
  ),
  'fritillaria_ruthenica': PlantInfo(
    label: 'fritillaria_ruthenica',
    nameRo: 'Fritilarie rusa',
    latin: 'Fritillaria ruthenica',
    status: 'CR',
  ),
  'galanthus_nivalis': PlantInfo(
    label: 'galanthus_nivalis',
    nameRo: 'Ghiocel',
    latin: 'Galanthus nivalis',
    status: 'CR',
  ),
  'glechoma_hederacea': PlantInfo(
    label: 'glechoma_hederacea',
    nameRo: 'Lumanarica pamantului',
    latin: 'Glechoma hederacea',
    status: 'LC',
  ),
  'helianthus_annuus': PlantInfo(
    label: 'helianthus_annuus',
    nameRo: 'Floarea-soarelui',
    latin: 'Helianthus annuus',
    status: 'LC',
  ),
  'hyssopus_officinalis': PlantInfo(
    label: 'hyssopus_officinalis',
    nameRo: 'Isop',
    latin: 'Hyssopus officinalis',
    status: 'LC',
  ),
  'iris_pumila': PlantInfo(
    label: 'iris_pumila',
    nameRo: 'Iris pitic',
    latin: 'Iris pumila',
    status: 'CR',
  ),
  'iris_sibirica': PlantInfo(
    label: 'iris_sibirica',
    nameRo: 'Stanjanel siberian',
    latin: 'Iris sibirica',
    status: 'CR',
  ),
  'iris_variegata': PlantInfo(
    label: 'iris_variegata',
    nameRo: 'Stanjanel de camp variat',
    latin: 'Iris variegata',
    status: 'EN',
  ),
  'lamium_album': PlantInfo(
    label: 'lamium_album',
    nameRo: 'Urzicuta moarta alba',
    latin: 'Lamium album',
    status: 'LC',
  ),
  'lavandula_angustifolia': PlantInfo(
    label: 'lavandula_angustifolia',
    nameRo: 'Lavanda',
    latin: 'Lavandula angustifolia',
    status: 'LC',
  ),
  'leucanthemum_vulgare': PlantInfo(
    label: 'leucanthemum_vulgare',
    nameRo: 'Romanita (margareta)',
    latin: 'Leucanthemum vulgare',
    status: 'LC',
  ),
  'lilium_martagon': PlantInfo(
    label: 'lilium_martagon',
    nameRo: 'Crin de padure',
    latin: 'Lilium martagon',
    status: 'CR',
  ),
  'matricaria_chamomilla': PlantInfo(
    label: 'matricaria_chamomilla',
    nameRo: 'Musete',
    latin: 'Matricaria chamomilla',
    status: 'LC',
  ),
  'mentha_piperita': PlantInfo(
    label: 'mentha_piperita',
    nameRo: 'Menta',
    latin: 'Mentha piperita',
    status: 'LC',
  ),
  'muscari_neglectum': PlantInfo(
    label: 'muscari_neglectum',
    nameRo: 'Muscari neglijat',
    latin: 'Muscari neglectum',
    status: 'NT',
  ),
  'narcissus_pseudonarcissus': PlantInfo(
    label: 'narcissus_pseudonarcissus',
    nameRo: 'Narcisa',
    latin: 'Narcissus pseudonarcissus',
    status: 'LC',
  ),
  'nuphar_lutea': PlantInfo(
    label: 'nuphar_lutea',
    nameRo: 'Nufar galben',
    latin: 'Nuphar lutea',
    status: 'VU',
  ),
  'nymphaea_alba': PlantInfo(
    label: 'nymphaea_alba',
    nameRo: 'Nufar alb',
    latin: 'Nymphaea alba',
    status: 'CR',
  ),
  'paeonia_tenuifolia': PlantInfo(
    label: 'paeonia_tenuifolia',
    nameRo: 'Bujor de stepa',
    latin: 'Paeonia tenuifolia',
    status: 'CR',
  ),
  'papaver_rhoeas': PlantInfo(
    label: 'papaver_rhoeas',
    nameRo: 'Mac de camp',
    latin: 'Papaver rhoeas',
    status: 'LC',
  ),
  'petunia_x_hybrida': PlantInfo(
    label: 'petunia_x_hybrida',
    nameRo: 'Petunia',
    latin: 'Petunia x hybrida',
    status: 'LC',
  ),
  'plantago_lanceolata': PlantInfo(
    label: 'plantago_lanceolata',
    nameRo: 'Patlagina ingusta',
    latin: 'Plantago lanceolata',
    status: 'LC',
  ),
  'platanthera_bifolia': PlantInfo(
    label: 'platanthera_bifolia',
    nameRo: 'Orhidee cu doua frunze',
    latin: 'Platanthera bifolia',
    status: 'EN',
  ),
  'rosa_x_hybrida': PlantInfo(
    label: 'rosa_x_hybrida',
    nameRo: 'Trandafir de gradina',
    latin: 'Rosa x hybrida',
    status: 'LC',
  ),
  'scilla_siberica': PlantInfo(
    label: 'scilla_siberica',
    nameRo: 'Viorele (scila)',
    latin: 'Scilla siberica',
    status: 'NT',
  ),
  'silybum_marianum': PlantInfo(
    label: 'silybum_marianum',
    nameRo: 'Ciulin (armurariu)',
    latin: 'Silybum marianum',
    status: 'LC',
  ),
  'tulipa_biebersteiniana': PlantInfo(
    label: 'tulipa_biebersteiniana',
    nameRo: 'Lalea salbatica Bieberstein',
    latin: 'Tulipa biebersteiniana',
    status: 'CR',
  ),
  'tulipa_gesneriana': PlantInfo(
    label: 'tulipa_gesneriana',
    nameRo: 'Lalea de gradina',
    latin: 'Tulipa gesneriana',
    status: 'LC',
  ),
  'typha_latifolia': PlantInfo(
    label: 'typha_latifolia',
    nameRo: 'Papura',
    latin: 'Typha latifolia',
    status: 'LC',
  ),
  'urtica_dioica': PlantInfo(
    label: 'urtica_dioica',
    nameRo: 'Urzica',
    latin: 'Urtica dioica',
    status: 'LC',
  ),
};

PlantInfo? getPlantInfo(String label) => plantInfoByLabel[label];

String getStatusLabelRo(String status) => plantStatusInfo[status]?.labelRo ?? status;

Color getStatusColor(String status) => plantStatusInfo[status]?.color ?? const Color(0xFF888888);

