import 'package:flutter/material.dart';

class PlantInfo {
  final String label;
  final String nameRo;
  final String latin;
  final String status;
  final String descriptionRo;
  final List<String> imageAssets;

  const PlantInfo({
    required this.label,
    required this.nameRo,
    required this.latin,
    required this.status,
    this.descriptionRo = 'Descriere in curs de completare.',
    this.imageAssets = const ['assets/plant_icon.jpg'],
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
    descriptionRo:
        'Omagul galben este o planta erbacee perena din familia Ranunculaceae, endemica zonelor montane din Europa de Est si Caucaz. '
        'Atinge inaltimi de 60–120 cm, cu tulpini erecte acoperite de peri moi si frunze palmat-lobate, de culoare verde-inchis, cu 5–7 lobi adanc divizati. '
        'Florile, de un galben-pal caracteristic, sunt grupate in raceme terminale dense si infloresc in iulie–august. '
        'Ca toate speciile de Aconitum, planta este extrem de toxica — alcaloizii din radacina (in special aconitina) pot fi letali chiar si in cantitati mici. '
        'In Moldova si Romania creste sporadic pe versanti nordici umezi, la marginea padurilor de fag si molid, la altitudini de 700–1500 m. '
        'Principalele amenintari sunt defrisarea habitatelor montane, pasunatul intensiv si colectarea necontrolata.',
    imageAssets: ['assets/plants/aconitum_lasiostomum.jpg'],
  ),
  'anemone_sylvestris': PlantInfo(
    label: 'anemone_sylvestris',
    nameRo: 'Anemona de padure',
    latin: 'Anemone sylvestris',
    status: 'VU',
    descriptionRo:
        'Anemona de padure este o planta erbacee perena din familia Ranunculaceae, larg raspandita in Europa Centrala si de Est, '
        'insa in declin vizibil din cauza pierderii habitatelor. Formeaza colonii mici in poieni, liziere si paduri rare de stejar sau carpen, '
        'preferand solurile calcaroase bine drenate. Tulpinile florale ating 15–40 cm inaltime si poarta cate o singura floare alba '
        'cu 5 petale si un disc central galben-auriu; infloreste in aprilie–mai, imediat dupa topirea zapezii. '
        'Frunzele bazale sunt trilobate si paroase, creand un covor verde dupa fructificare, iar fructele sunt achene cu puf alb matasos, purtate de vant. '
        'Specia este sensibila la intensificarea agriculturii, la inchiderea padurilor si la recoltarea florilor pentru buchete.',
    imageAssets: ['assets/plants/anemone_sylvestris.jpg'],
  ),
  'campanula_sibirica': PlantInfo(
    label: 'campanula_sibirica',
    nameRo: 'Clopotel siberian',
    latin: 'Campanula sibirica',
    status: 'EN',
    descriptionRo:
        'Clopotelul siberian este o planta bienala sau perena scurta din familia Campanulaceae, caracteristica stepelor si pajistitilor uscate '
        'din Europa de Est, Siberia si Asia Centrala. Tulpinile rigide, paroase, ating 20–50 cm, cu frunze lanceolate aspre. '
        'Florile sunt tubular-campanulate, de un albastru-violet intens, grupate in cime cu ramuri scurte; infloreste din iunie pana in august. '
        'Specia prefera soluri calcaroase sau nisipoase, bine expuse la soare. '
        'In Moldova este consemnata pe pantele uscate din sudul tarii si pe marginile de drum neperturbate. '
        'Declinul sau este cauzat de aratul pajistitilor naturale, de invazia speciilor adventive si de incetarea cosirilor traditionale '
        'care mentineau habitatul deschis.',
    imageAssets: ['assets/plants/campanula_sibirica.jpg'],
  ),
  'centaurea_cyanus': PlantInfo(
    label: 'centaurea_cyanus',
    nameRo: 'Albastrele',
    latin: 'Centaurea cyanus',
    status: 'LC',
    descriptionRo:
        'Albastrele sunt plante anuale sau bienale din familia Asteraceae, odata omniprezente in campurile de grau, acum mai rare '
        'din cauza erbicidelor moderne. Tulpinile, de 30–80 cm, sunt ramificate si usor fainate, cu frunze inguste, lanceolate. '
        'Floricelele albastre-cobalt, grupate in capitule de 2–3 cm, infloresc din mai pana in septembrie. '
        'Prefera soluri aerate, sarace si bine drenate, fara umiditate excesiva. '
        'Sunt plante melifere valoroase si gazde pentru diverse insecte, inclusiv bondari. '
        'In trecut serveau ca indicatori ai solurilor fertile nearate cu erbicide; astazi sunt recultivate intentionat '
        'in gradini rustice si pe marginile campurilor ca benzi florale pentru biodiversitate.',
    imageAssets: ['assets/plants/centaurea_cyanus.jpg'],
  ),
  'chrysanthemum_x_morifolium': PlantInfo(
    label: 'chrysanthemum_x_morifolium',
    nameRo: 'Crizantema',
    latin: 'Chrysanthemum x morifolium',
    status: 'LC',
    descriptionRo:
        'Crizantema de gradina este un hibrid complex din familia Asteraceae, obtinut din specii asiatice si cultivat de peste 2500 de ani. '
        'Formele moderne includ mii de soiuri cu flori simple, pompon, sferic, anemoniforme sau in forma de lingura, '
        'in paleta cromatica completa exceptand albastrul. Infloreste toamna (septembrie–noiembrie), cand ziua scade sub 12 ore, '
        'fiind o planta de zi scurta. Tulpinile ating 30–90 cm, cu frunze adanc lobate si aromate la frecare. '
        'Este planta perena rezistenta la bruma usoara, dar sensibila la inghet puternic si la umezeala excesiva la radacina. '
        'In horticultura este apreciata atat ca floare de gradina, cat si ca floare taiata cu durata lunga in vaza.',
    imageAssets: ['assets/plants/chrysanthemum_x_morifolium.jpg'],
  ),
  'colchicum_autumnale': PlantInfo(
    label: 'colchicum_autumnale',
    nameRo: 'Brandusa de toamna',
    latin: 'Colchicum autumnale',
    status: 'NT',
    descriptionRo:
        'Brandusa de toamna este o planta bulboasa perena din familia Colchicaceae, prezenta in fanetele umede si poienile de campie '
        'din Europa Centrala si de Sud-Est. Florile roz-liliachii, cu sase tepale si fara frunze, apar direct din sol in august–octombrie, '
        'ceea ce i-a adus porecla "fiul fara tata". Frunzele, mari si lucioase, se dezvolta abia in primavara urmatoare, '
        'odata cu capsulele fructifere. Intreaga planta — bulb, frunze, flori, seminte — contine colchicina, '
        'un alcaloid puternic toxic, folosit totusi in medicina pentru tratamentul gutei si in cercetarea genetica. '
        'Pasunatul excesiv si drenarea terenurilor umede reprezinta principalele pericole pentru aceasta specie.',
    imageAssets: ['assets/plants/colchicum_autumnale.jpg'],
  ),
  'convallaria_majalis': PlantInfo(
    label: 'convallaria_majalis',
    nameRo: 'Lacramioare',
    latin: 'Convallaria majalis',
    status: 'EN',
    descriptionRo:
        'Lacramioarele sunt plante rizomatoase perene din familia Asparagaceae, ocrotite prin lege in multe tari europene. '
        'Cresc in paduri umbroase de foioase, pe soluri acide, humoase si bine umede, formand uneori covoare extinse. '
        'Doua frunze mari, oval-lanceolate si lucioase, cuprind in primavara (mai–iunie) o tulpina florala scurta '
        'cu 5–12 clopote albi, globulosi, cu un parfum intens si inconfundabil. Fructele sunt bobite rosii-caramizii, toxice. '
        'Toate partile plantei contin glicozide cardiotonice (convalatoxina, convalozida) care o fac extrem de periculoasa daca este ingerata. '
        'Culegerea masiva pentru floristica si comercializarea ilegala sunt principalele amenintari in Romania si Moldova.',
    imageAssets: ['assets/plants/convallaria_majalis.jpg'],
  ),
  'dianthus_carthusianorum': PlantInfo(
    label: 'dianthus_carthusianorum',
    nameRo: 'Garoafa de stepa',
    latin: 'Dianthus carthusianorum',
    status: 'NT',
    descriptionRo:
        'Garoafa de stepa este o planta erbacee perena din familia Caryophyllaceae, emblematica pentru pajistile continentale uscate. '
        'Tulpinile subtiri, erecte (20–45 cm), poarta la varf 3–20 flori de un roz-carmin stralucitor, grupate intr-un capat dens. '
        'Petalele au marginea dintelata caracteristica genului Dianthus, iar caliciul este inconjurat de bractee brune, lungi. '
        'Infloreste din mai pana in septembrie. Specia prefera soluri sarace in nutrienti, alcaline sau neutre, '
        'in zone deschise si insorite: pajisti xerofile, margini de cale ferata si taluzuri. '
        'Este sensibila la ingrasarea solului, la inmultirea arborilor si la cosirile prea timpurii sau prea frecvente.',
    imageAssets: ['assets/plants/dianthus_carthusianorum.jpg'],
  ),
  'fritillaria_ruthenica': PlantInfo(
    label: 'fritillaria_ruthenica',
    nameRo: 'Fritilarie rusa',
    latin: 'Fritillaria ruthenica',
    status: 'CR',
    descriptionRo:
        'Fritilaria rusa este o specie bulboasa din familia Liliaceae, deosebit de rara si amenintata critic pe teritoriul Moldovei si Romaniei. '
        'Bulbii sunt mici, alb-galbui, cu solzi numerosi. Tulpina (20–50 cm) este zvelta, cu frunze liniare alterne '
        'si cateva in varf rasucite in carcel, ceea ce ajuta planta sa se sprijine printre ierburi inalte. '
        'Florile in forma de clopot, brun-oliv cu retea de patratele verzui, atarna solitare sau in grupuri de 2–3 '
        'si infloresc in aprilie–mai. Prefera luncile umede, pajistile de lunca si lizierele cu vegetatie bogata. '
        'Este extrem de vulnerabila la drenarea terenurilor inundabile, la defrisare si la colectarea ilegala a bulbilor.',
    imageAssets: ['assets/plants/fritillaria_ruthenica.jpg'],
  ),
  'galanthus_nivalis': PlantInfo(
    label: 'galanthus_nivalis',
    nameRo: 'Ghiocel',
    latin: 'Galanthus nivalis',
    status: 'CR',
    descriptionRo:
        'Ghiocelul este cel mai cunoscut mesager al primaverii, o planta bulboasa mica din familia Amaryllidaceae. '
        'Bulbul oval produce primavara devreme (ianuarie–martie) doua frunze liniare, albastru-verzui, '
        'si o tulpina florala de 7–15 cm cu un singur clopot alb pendent, alcatuit din 3 tepale externe '
        'si 3 tepale interne cu o pata verde caracteristica la varf. '
        'Creste spontan in paduri de foioase umede, in lunci si poieni, preferand soluri bogate si semiumbroase. '
        'Este ocrotit prin lege in Romania si Moldova: culegerea, comercializarea si exportul sunt interzise. '
        'Populatiile naturale sunt amenintate de culegerea masiva in scop ornamental, de pierderea padurilor riverane '
        'si de compactarea solului prin pasunatul in zone de padure.',
    imageAssets: ['assets/plants/galanthus_nivalis.jpg'],
  ),
  'glechoma_hederacea': PlantInfo(
    label: 'glechoma_hederacea',
    nameRo: 'Lumanarica pamantului',
    latin: 'Glechoma hederacea',
    status: 'LC',
    descriptionRo:
        'Lumanarica pamantului este o planta perena taratoare din familia Lamiaceae, cu tulpini patrunghiulare '
        'ce se inradacineaza la noduri si formeaza rapid covoare dese. Frunzele reniforme, cu marginea crenat-dentata, '
        'emit un miros puternic aromat la strivire. Florile bilobate, liliachiu-albastre, cu puncte violet in interior, '
        'apar in martie–iunie si sunt deosebit de atractive pentru albine, oferind nectar si polen timpuriu. '
        'Creste in gradini, pe margini de drumuri, in garduri si paduri umbroase. '
        'Este utilizata traditional in fitoterapie ca infuzie pentru tuse si afectiuni bronhice '
        'si ca planta aromatica culinara in unele bucatarii regionale.',
    imageAssets: ['assets/plants/glechoma_hederacea.jpg'],
  ),
  'helianthus_annuus': PlantInfo(
    label: 'helianthus_annuus',
    nameRo: 'Floarea-soarelui',
    latin: 'Helianthus annuus',
    status: 'LC',
    descriptionRo:
        'Floarea-soarelui este o planta anuala originara din America de Nord, cultivata la scara mondiala pentru semintele oleaginoase. '
        'Tulpina robusta, aspra, poate atinge 1,5–3 m inaltime, cu frunze mari, cordate, usor aspre la pipait. '
        'Capitulul floral poate depasi 30 cm in diametru la soiurile agricole; florile externe sunt ligulate si sterile (galbene), '
        'cele centrale tubulare si fertile. Tineretea capitulului urmareste miscarea soarelui (heliotropism), '
        'dar la maturitate ramane orientat spre est. '
        'Moldova este unul dintre principalii producatori regionali de floarea-soarelui, cultura ocupand suprafete agricole extinse. '
        'Exista si soiuri ornamentale cu flori duble sau in tonuri de bronz, portocaliu si maro, populare in gradini.',
    imageAssets: ['assets/plants/helianthus_annuus.jpg'],
  ),
  'hyssopus_officinalis': PlantInfo(
    label: 'hyssopus_officinalis',
    nameRo: 'Isop',
    latin: 'Hyssopus officinalis',
    status: 'LC',
    descriptionRo:
        'Isopul este un subarbust semipersistent aromat din familia Lamiaceae, originar din bazinul mediteranean si Asia Centrala. '
        'Tulpinile lemnoase la baza ating 20–60 cm, cu frunze liniare, glandulos-punctate, intens aromate. '
        'Florile tubulare, bilobate, de culoare albastru-violet (rar roz sau albe), sunt grupate in spice unilaterale '
        'si infloresc din iulie pana in septembrie, atragandd masiv albinele. '
        'Este una dintre cele mai vechi plante medicinale si condimentare cunoscute, mentionata in textele biblice. '
        'Uleiul esential este expectorant si antiseptic; se foloseste la aromatizarea unor lichioruri renumite '
        'si ca condiment in bucataria mediteraneana. Prefera soluri calcaroase, uscate, in pozitii sudice si insorite.',
    imageAssets: ['assets/plants/hyssopus_officinalis.jpg'],
  ),
  'iris_pumila': PlantInfo(
    label: 'iris_pumila',
    nameRo: 'Iris pitic',
    latin: 'Iris pumila',
    status: 'CR',
    descriptionRo:
        'Irisul pitic este cea mai mica specie de iris europeana (5–15 cm inaltime), apartinand familiei Iridaceae. '
        'Rizomul taritor produce in aprilie–mai flori mari in raport cu talia plantei, de culoare violet-albastruie pana la galbena sau alba, '
        'cu petale externe largi, catifelate, si o barba galbena caracteristica. '
        'Creste pe coaste nisipoase sau calcaroase stepice, in conditii de seceta pronuntata si ger intens. '
        'In Moldova este consemnat pe stancarii si pajisti de loess din sudul si centrul tarii, '
        'dar populatiile s-au redus dramatic din cauza conversiei stepelor in terenuri agricole si a suprapasunatului. '
        'Este ocrotit prin Cartea Rosie a Republicii Moldova.',
    imageAssets: ['assets/plants/iris_pumila.jpg'],
  ),
  'iris_sibirica': PlantInfo(
    label: 'iris_sibirica',
    nameRo: 'Stanjanel siberian',
    latin: 'Iris sibirica',
    status: 'CR',
    descriptionRo:
        'Stanjanelul siberian este o planta rizomatoasa viguroasa din familia Iridaceae, atingand 40–100 cm inaltime. '
        'Frunzele sunt inguste, lanceolate, formeaza smocuri dese de culoare verde-intensa. '
        'Florile, de un albastru-violet pur, cu venisoare albe si galbene pe petalele externe, infloresc in mai–iunie. '
        'Specia prefera pajistile umede, marginile de balti si cursurile de apa lente, pe soluri grele, temporar inundate. '
        'Este una dintre cele mai vulnerabile specii de lunca din Moldova: drenarea campurilor inundabile, '
        'regularizarea raurilor si cosirile prea timpurii au dus la disparitia majoritatii populatiilor cunoscute. '
        'Este inclusa in Cartea Rosie a Republicii Moldova si necesita protectie stricta a habitatelor de lunca.',
    imageAssets: ['assets/plants/iris_sibirica.jpg'],
  ),
  'iris_variegata': PlantInfo(
    label: 'iris_variegata',
    nameRo: 'Stanjanel de camp variat',
    latin: 'Iris variegata',
    status: 'EN',
    descriptionRo:
        'Stanjanelul de camp variat este endemic Balcanilor si Europei Centrale, raspandit pe pajisti uscate, coaste calcaroase '
        'si paduri de stejar rarefiete, la altitudini mici si medii. Tulpina (20–40 cm) poarta 2–3 flori cu petale externe '
        'galben-crem decorate cu retea de vinisoare mov-violacee, iar petalele interne sunt albe sau galbui. '
        'Aceasta combinatie cromatica distincta il face usor de recunoscut in camp. Infloreste in mai–iunie. '
        'Este amenintat de inchiderea peisajului prin invazia tufisurilor dupa abandonarea pasunatului traditional '
        'si de colectarea plantelor intregi din natura pentru gradini particulare.',
    imageAssets: ['assets/plants/iris_variegata.jpg'],
  ),
  'lamium_album': PlantInfo(
    label: 'lamium_album',
    nameRo: 'Urzicuta moarta alba',
    latin: 'Lamium album',
    status: 'LC',
    descriptionRo:
        'Urzicuta moarta alba este o planta erbacee perena din familia Lamiaceae, frecventa pe margini de drumuri, garduri, '
        'terenuri ruderale si liziere de padure din intreaga Europa temperata. '
        'Seamana frapant cu urzica adevarata — frunze oval-cordate, dintat-crenate, cu peri — dar nu are peri urticanti, '
        'de unde vine si denumirea populara de urzica moarta. '
        'Florile albe, cu doua buze pronuntate, sunt dispuse in verticile axilare si infloresc din mai pana in septembrie. '
        'Sunt extrem de atractive pentru bumbacari si albine, care acceseaza nectarul din tubul corolei. '
        'Folosita in medicina populara ca hemostatic si antiinflamator; frunzele tinere sunt comestibile fierte.',
    imageAssets: ['assets/plants/lamium_album.jpg'],
  ),
  'lavandula_angustifolia': PlantInfo(
    label: 'lavandula_angustifolia',
    nameRo: 'Lavanda',
    latin: 'Lavandula angustifolia',
    status: 'LC',
    descriptionRo:
        'Lavanda este un subarbust peren aromat din familia Lamiaceae, originar din Mediterana, cultivat in toata lumea temperata '
        'pentru uleiul esential, pentru frumusetea florilor si pentru rezistenta remarcabila la seceta. '
        'Tulpinile lemnoase la baza formeaza tufe rotunde de 30–60 cm, cu frunze inguste, gri-verzui, persistent aromate. '
        'Spicele florale, de 5–10 cm, sunt purpuriu-albastre si apar in iunie–august, atragandd albinele in numar mare. '
        'Uleiul esential, bogat in linalool si acetat de linalil, are proprietati antiseptice, anxiolitice si calmante, '
        'folosite pe scara larga in aromoterapie, cosmetica si farmaceutica. '
        'Este si una dintre cele mai decorative plante pentru garduri vii joase si borduri in stil mediteranean.',
    imageAssets: ['assets/plants/lavandula_angustifolia.jpg'],
  ),
  'leucanthemum_vulgare': PlantInfo(
    label: 'leucanthemum_vulgare',
    nameRo: 'Romanita (margareta)',
    latin: 'Leucanthemum vulgare',
    status: 'LC',
    descriptionRo:
        'Margareta este una dintre cele mai cunoscute si iubite flori salbatice din Europa, apartinand familiei Asteraceae. '
        'Planta perena (20–60 cm) formeaza rozete bazale din care pornesc tulpini cu frunze lobate, spatulate la baza. '
        'Capitulele au un disc central galben si 20–30 ligule albe lungi, cu diametrul de 3–6 cm; infloreste mai–septembrie. '
        'Prefera fanete, livezi si margini de drum cu sol bine drenat si pH neutru pana la slab alcalin. '
        'Este toleranta la cosit si refloreste rapid dupa taiere, motiv pentru care s-a mentinut bine '
        'in pajistile traditional cosierte. Este o planta melifera importanta si gazda pentru numeroase specii de fluturi si bumbacari.',
    imageAssets: ['assets/plants/leucanthemum_vulgare.jpg'],
  ),
  'lilium_martagon': PlantInfo(
    label: 'lilium_martagon',
    nameRo: 'Crin de padure',
    latin: 'Lilium martagon',
    status: 'CR',
    descriptionRo:
        'Crinul de padure este una dintre cele mai spectaculoase plante spontane din Europa, apartinand familiei Liliaceae. '
        'Bulbul galben-portocaliu produce o tulpina robusta de 50–150 cm, cu frunze dispuse in verticile. '
        'Florile, de culoare roz-liliachie cu puncte brun-inchise si cu tepale puternic recurvate in forma de turban, '
        'atarna in raceme de 5–20 exemplare si emana un parfum puternic, mai ales seara, pentru a atrage polenizatorii nocturni. '
        'Infloreste in iunie–iulie. Prefera paduri umbroase de fag si brad, cu humus abundent si umiditate constanta. '
        'Culegerea ilegala a florilor si dezradacinarea bulbilor pentru gradini sunt principalele cauze ale declinului sau '
        'in Moldova, unde este ocrotit prin lege.',
    imageAssets: ['assets/plants/lilium_martagon.jpg'],
  ),
  'matricaria_chamomilla': PlantInfo(
    label: 'matricaria_chamomilla',
    nameRo: 'Musete',
    latin: 'Matricaria chamomilla',
    status: 'LC',
    descriptionRo:
        'Musetelul este planta medicinala numarul unu in medicina traditionala europeana, o anuala sau bienala subtire (20–50 cm) '
        'din familia Asteraceae. Frunzele sunt fin divizate, pana in segmente filiforme, creand un aspect aerisit. '
        'Capitulele cu disc galben convex si ligule albe reflexe infloresc din mai pana in septembrie. '
        'Receptaculul gol pe interior — caracter distinctiv fata de speciile false — contine ulei esential bogat '
        'in chamazulena si bisabolol cu efect antiinflamator, antispasmodic si calmant. '
        'Creste pe soluri reavene, arate sau deranjate: ogoare, margini de drum, santuri. '
        'In Moldova se cultiva si industrial, produsul principal fiind florile uscate pentru ceai si extracte farmaceutice.',
    imageAssets: ['assets/plants/matricaria_chamomilla.jpg'],
  ),
  'mentha_piperita': PlantInfo(
    label: 'mentha_piperita',
    nameRo: 'Menta',
    latin: 'Mentha piperita',
    status: 'LC',
    descriptionRo:
        'Menta este un hibrid steril (Mentha aquatica × Mentha spicata) din familia Lamiaceae, reprodus exclusiv vegetativ '
        'prin stoloni si rizomi. Tulpinile patrunghiulare, de 30–90 cm, cu frunze oval-lanceolate dintat-serificate, '
        'emana un miros intens mentolat la simpla atingere. '
        'Florile mici, liliachii-purpurii, sunt grupate in spice terminale si infloresc iulie–septembrie. '
        'Creste viguroasa in orice sol umed si bogat, putand deveni invaziva rapid prin extindere rizomala. '
        'Uleiul esential, bogat in mentol si mentona, este folosit pe scara larga in farmaceutica, alimentatie, '
        'cosmetica si aromoterapie. Moldova exporta cantitati semnificative de mentol si ulei de menta spre piata europeana.',
    imageAssets: ['assets/plants/mentha_piperita.jpg'],
  ),
  'muscari_neglectum': PlantInfo(
    label: 'muscari_neglectum',
    nameRo: 'Muscari neglijat',
    latin: 'Muscari neglectum',
    status: 'NT',
    descriptionRo:
        'Muscari neglijat este o mica planta bulboasa de primavara din familia Asparagaceae, frecvent confundata cu specii inrudite. '
        'Bulbii albiciosi produc in martie–mai 4–6 frunze liniare, semirigide, si tulpini florale de 10–20 cm '
        'cu inflorescente dense in forma de strugure: florile inferioare sunt albastru-inchis, aproape negricioase, '
        'cele superioare mai deschise la culoare si sterile. '
        'Colonizeaza pajisti uscate, vii abandonate, coaste cu vegetatie rara si liziere de padure, pe soluri sarace. '
        'In Moldova este inca relativ frecvent in zone neperturbate, insa aratura si utilizarea erbicidelor '
        'reduc constant populatiile naturale.',
    imageAssets: ['assets/plants/muscari_neglectum.jpg'],
  ),
  'narcissus_pseudonarcissus': PlantInfo(
    label: 'narcissus_pseudonarcissus',
    nameRo: 'Narcisa',
    latin: 'Narcissus pseudonarcissus',
    status: 'LC',
    descriptionRo:
        'Narcisa salbatica este o planta bulboasa perena din familia Amaryllidaceae, nativa in Europa de Vest, '
        'naturalizata si cultivata pe scara larga in toata Europa temperata. '
        'Bulbii tunicati produc primavara (martie–mai) 2–3 frunze glauce liniare si o tulpina florala de 20–40 cm '
        'cu o singura floare mare: coroana (trompeta) galbena lunga, inconjurata de 6 tepale galbene mai deschise. '
        'In pajisti naturale umede poate forma covoare spectaculoase de culoare galbena. '
        'Toate partile contin alcaloizi narcicladini puternic toxici daca sunt ingerati; sucul bulbilor poate irita pielea. '
        'Soiurile horticole, mult mai variate cromatic, sunt printre cele mai populare bulboase de gradina din lume.',
    imageAssets: ['assets/plants/narcissus_pseudonarcissus.jpg'],
  ),
  'nuphar_lutea': PlantInfo(
    label: 'nuphar_lutea',
    nameRo: 'Nufar galben',
    latin: 'Nuphar lutea',
    status: 'VU',
    descriptionRo:
        'Nufarul galben este o planta acvatica perena din familia Nymphaeaceae, cu rizom gros, carnos, fixat in namol '
        'la adancimi de 0,5–3 m. Frunzele plutitoare, oval-eliptice, ating 25–40 cm lungime, cu nervuri proeminente '
        'pe fata inferioara; exista si frunze submerse, subtiri si transparente. '
        'Florile globuloase, galbene, cu diametrul de 4–6 cm, stau deasupra apei pe pedunculi rigizi '
        'si infloresc din mai pana in august, cu un miros slab alcoolic specific. '
        'Indica ape curate, cu miscare lenta, in rauri, lacuri si balti. '
        'Poluarea apelor, regularizarea albiilor, colmatarea si culegerea florilor constituie principalele amenintari.',
    imageAssets: ['assets/plants/nuphar_lutea.jpg'],
  ),
  'nymphaea_alba': PlantInfo(
    label: 'nymphaea_alba',
    nameRo: 'Nufar alb',
    latin: 'Nymphaea alba',
    status: 'CR',
    descriptionRo:
        'Nufarul alb este simbolul apelor curate si linistite, una dintre cele mai frumoase plante acvatice spontane din Europa. '
        'Rizomul puternic, innodat, se fixeaza in malul lacurilor si baltilor pe adancimi de 1–3 m. '
        'Frunzele circulare, cu un sinus adanc, plutesc la suprafata si pot atinge 30 cm in diametru. '
        'Florile albe, cu 20–25 petale dispuse in spirala si un disc de stamine galbene, infloresc din mai pana in septembrie, '
        'inchizandu-se seara si redeschizandu-se dimineata. '
        'Specia este extrem de sensibila la poluare si la perturbarea mecanica a fundului apei. '
        'In Moldova populatiile naturale au scazut dramatic; este protejata prin lege si inclusa in Cartea Rosie a Republicii Moldova.',
    imageAssets: ['assets/plants/nymphaea_alba.jpg'],
  ),
  'paeonia_tenuifolia': PlantInfo(
    label: 'paeonia_tenuifolia',
    nameRo: 'Bujor de stepa',
    latin: 'Paeonia tenuifolia',
    status: 'CR',
    descriptionRo:
        'Bujorul de stepa este una dintre cele mai rare si mai ocrotite plante din Moldova, simbol al patrimoniului natural national. '
        'Spre deosebire de bujorul de padure, are frunzele fin-sectate pana in segmente filiforme, creand un aspect dantelos distinctiv. '
        'Florile solitare, rosii-stralucitoare, cu 5 petale late si un manunchi de stamine galbene, infloresc spectaculos in mai. '
        'Creste exclusiv pe stepe ierboase native, pe coaste cu iarba scurta si sol superficial. '
        'A disparut din marea majoritate a localitatilor istorice din cauza araturii stepelor, suprapasunatului si colectarii ilegale. '
        'Rezervatia "Plaiul Fagului" si cateva arii protejate din sudul Moldovei adapostesc ultimele populatii viabile.',
    imageAssets: ['assets/plants/paeonia_tenuifolia.jpg'],
  ),
  'papaver_rhoeas': PlantInfo(
    label: 'papaver_rhoeas',
    nameRo: 'Mac de camp',
    latin: 'Papaver rhoeas',
    status: 'LC',
    descriptionRo:
        'Macul de camp este una dintre florile salbatice cu cea mai bogata incarcare culturala si simbolica din Europa, '
        'o anuala din familia Papaveraceae. Tulpinile (20–80 cm), peroase si ramificate, poarta flori solitare de 5–9 cm '
        'cu petale rosii-stralucitoare si o pata neagra bazala; infloreste mai–iulie. '
        'Capsulele fructifere contin mii de seminte minuscule care pot ramane viabile in sol 40–80 de ani, '
        'germinand masiv dupa aratura sau deranjarea solului. '
        'Nu contine morfina (spre deosebire de Papaver somniferum), ci alcaloizi mai putin puternici. '
        'Odata simbol al lanurilor de grau, a disparut din campurile tratate cu erbicide, '
        'insa revine in gradini de tip wildflower si in campurile de agricultura ecologica.',
    imageAssets: ['assets/plants/papaver_rhoeas.jpg'],
  ),
  'petunia_x_hybrida': PlantInfo(
    label: 'petunia_x_hybrida',
    nameRo: 'Petunia',
    latin: 'Petunia x hybrida',
    status: 'LC',
    descriptionRo:
        'Petuniile sunt plante anuale semitaratoare sau erecte din familia Solanaceae, hibridate din specii sud-americane. '
        'Produc un afisaj floral spectaculos si aproape neintrerupt din mai pana in bruma, in orice culoare imaginabila, '
        'inclusiv dungi, borduri si forme duble. Tulpinile sunt viscoase la atingere, cu peri glandulosi, '
        'ajungand la 20–60 cm lungime. '
        'Sunt ideale pentru ghivece suspendate, jardiniere de balcon si borduri de gradina. '
        'Exista trei categorii principale: Grandiflora (flori mari, mai sensibile la ploaie), '
        'Multiflora (flori medii, rezistente) si Milliflora (compacte, cu flori mici si foarte numeroase). '
        'Nu rezista la inghet si se trateaza ca anuale in clima temperata.',
    imageAssets: ['assets/plants/petunia_x_hybrida.jpg'],
  ),
  'plantago_lanceolata': PlantInfo(
    label: 'plantago_lanceolata',
    nameRo: 'Patlagina ingusta',
    latin: 'Plantago lanceolata',
    status: 'LC',
    descriptionRo:
        'Patlagina ingusta este o planta erbacee perena din familia Plantaginaceae, raspandita in toata lumea temperata '
        'ca buruiana rezistenta, dar si ca planta medicinala valoroasa. '
        'Frunzele lanceolate, cu 3–5 nervuri paralele proeminente, formeaza o rozeta bazala compacta. '
        'Tulpinile florale de 20–50 cm se termina cu un spic cilindric dens de flori verzui-albicioase cu antere violete. '
        'Polenul sau este un alergen major in aer primavara–vara. '
        'Frunzele contin aucubina (iridoid glicozid) si mucilaje cu efect antiinflamator si cicatrizant, '
        'folosite traditional in comprese pentru rani, intepaturi de insecte si afectiuni ale cailor respiratorii.',
    imageAssets: ['assets/plants/plantago_lanceolata.jpg'],
  ),
  'platanthera_bifolia': PlantInfo(
    label: 'platanthera_bifolia',
    nameRo: 'Orhidee cu doua frunze',
    latin: 'Platanthera bifolia',
    status: 'EN',
    descriptionRo:
        'Platanthera bifolia este o orhidee terestra nativa din familia Orchidaceae, una dintre cele mai elegante plante salbatice europene. '
        'Denumirea vine de la cele doua frunze bazale mari, oval-eliptice si lucioase, dispuse opus la baza tulpinii. '
        'Tulpina florala (20–45 cm) poarta un racem dens cu 15–30 flori albe, cu un pinten lung si subtire, '
        'parfumate intens noaptea pentru a atrage fluturii nocturni polenizatori. Infloreste in mai–iulie '
        'in fanete bogate si lumisiti de padure cu sol calcaros. '
        'Este strict protejata; culegerea este interzisa prin lege. '
        'Principalele amenintari sunt fertilizarea agricola, care favorizeaza iarba grasa ce suprima planta, '
        'si abandonarea cosirilor traditionale care mentineau habitatele deschise.',
    imageAssets: ['assets/plants/platanthera_bifolia.jpg'],
  ),
  'rosa_x_hybrida': PlantInfo(
    label: 'rosa_x_hybrida',
    nameRo: 'Trandafir de gradina',
    latin: 'Rosa x hybrida',
    status: 'LC',
    descriptionRo:
        'Trandafirul de gradina este regele ornamentalelor, un hibrid complex din familia Rosaceae, cu mii de soiuri clasificate in grupe: '
        'hibrizi de ceai (flori mari solitare), floribunde (buchete dense), urcatori, miniatura si altele. '
        'Infloreste din mai pana in noiembrie, cu varf in iunie si septembrie, cu flori puternic parfumate '
        'in paleta cromatica completa. Tulpinile sunt acoperite cu ghimpi de marimi variate, iar frunzele sunt penate, '
        'lucios-verde. Fructele (macesele) sunt bogate in vitamina C si folosite in ceaiuri si dulceturi. '
        'Este ornamentala cu cea mai lunga istorie culturala si simbolica din lume, cultivata de peste 5000 de ani.',
    imageAssets: ['assets/plants/rosa_x_hybrida.jpg'],
  ),
  'scilla_siberica': PlantInfo(
    label: 'scilla_siberica',
    nameRo: 'Viorele (scila)',
    latin: 'Scilla siberica',
    status: 'NT',
    descriptionRo:
        'Viorelele sunt mici plante bulboase de primavara din familia Asparagaceae, originare din Asia Mica si sudul Rusiei, '
        'naturalizate in Europa Centrala si de Est. Bulbii mici produc 2–4 frunze liniare si tulpini florale de 10–20 cm '
        'cu 1–5 flori albastre-cobalt, patente, ce apar in martie–aprilie, de obicei inaintea frunzelor copacilor. '
        'Colonizeaza pante umede, poieni de padure si pajisti semi-umbrite. '
        'Sunt rezistente la inghet si tolereaza umbra variabila, inmultindu-se natural prin seminte si bulbili, '
        'formand in timp colonii extinse. Desi inca frecvente in unele zone, sunt amenintate de urbanizare '
        'si de culegerea excesiva pentru buchete de primavara.',
    imageAssets: ['assets/plants/scilla_siberica.jpg'],
  ),
  'silybum_marianum': PlantInfo(
    label: 'silybum_marianum',
    nameRo: 'Ciulin (armurariu)',
    latin: 'Silybum marianum',
    status: 'LC',
    descriptionRo:
        'Armurarul este o planta bienala impunatoare din familia Asteraceae, originara din Mediterana, naturalizata in Moldova si Romania. '
        'In primul an formeaza o rozeta de frunze mari, lucioase, verzi cu pete albe si nervuri, cu margini puternic spinoase. '
        'In al doilea an tulpina (60–150 cm) poarta capitule solitare, rotunde, de 4–7 cm, '
        'cu flori purpuriu-violet si bractee terminate in spini puternici. '
        'Achenele contin silimarina, un complex de flavonoliganani cu efect hepatoprotector demonstrat clinic, '
        'larg folosit in tratamentul hepatitelor si cirozei. '
        'Creste pe terenuri ruderale, margini de drum si pante uscate, fiind remarcabil de rezistenta la seceta si la inghet.',
    imageAssets: ['assets/plants/silybum_marianum.jpg'],
  ),
  'tulipa_biebersteiniana': PlantInfo(
    label: 'tulipa_biebersteiniana',
    nameRo: 'Lalea salbatica Bieberstein',
    latin: 'Tulipa biebersteiniana',
    status: 'CR',
    descriptionRo:
        'Laleaua salbatica Bieberstein este o specie mica si rara din familia Liliaceae, endemica stepelor pontice si a Crimeii. '
        'Bulbii mici, cu tunici brune, produc in aprilie–mai 2–3 frunze liniare glauce si o tulpina florala de 10–30 cm '
        'cu o singura floare galben-aurie stralucitoare, cu petale externe rosii pe dos. '
        'Creste pe coaste pietroase sau stancarii calcaroase expuse la soare, in asociatii stepice native. '
        'In Moldova este extrem de rara, cu populatii izolate in sudul tarii. '
        'Este amenintata critic de distrugerea habitatelor stepice, de suprapasunaj si de colectarea bulbilor si a florilor '
        'de catre colectionari si turisti.',
    imageAssets: ['assets/plants/tulipa_gesneriana.jpg'],
  ),
  'tulipa_gesneriana': PlantInfo(
    label: 'tulipa_gesneriana',
    nameRo: 'Lalea de gradina',
    latin: 'Tulipa gesneriana',
    status: 'LC',
    descriptionRo:
        'Laleaua de gradina este cel mai popular simbol al primaverii, un hibrid horticol complex din familia Liliaceae, '
        'derivat din specii anatoliene si centro-asiatice, cultivat si perfectionat de secole in Olanda si Turcia. '
        'Mii de soiuri sunt clasificate in 15 clase oficiale: simple timpurii, duble, papagal, fimbriate, viridiflora si altele. '
        'Infloresc in functie de soi intre martie si mai, cu flori in orice culoare exceptand albastrul pur. '
        'Bulbii au nevoie obligatorie de o perioada de frig (vernalizare) pentru a inflori, motiv pentru care se planteaza toamna. '
        'Dupa inflorire frunzisul se ingalbeneste treptat in 6 saptamani, timp in care bulbul isi acumuleaza rezervele pentru sezonul urmator.',
    imageAssets: ['assets/plants/tulipa_gesneriana.jpg'],
  ),
  'typha_latifolia': PlantInfo(
    label: 'typha_latifolia',
    nameRo: 'Papura',
    latin: 'Typha latifolia',
    status: 'LC',
    descriptionRo:
        'Papura este o planta erbacee acvatica perena din familia Typhaceae, dominanta la marginea lacurilor, baltilor '
        'si raurilor cu curgere lenta din intreaga emisfera nordica. '
        'Tulpinile cilindrice, fara noduri, ating 1,5–3 m inaltime, cu frunze lineare late (1–2 cm) si nervuri paralele. '
        'Inflorescentele sunt caracteristice: un cilindru compact brun-inchis (spicul femel, de 10–20 cm) '
        'deasupra caruia sta un spic mascul galben care elibereaza nori de polen la maturitate. '
        'Rizomii puternici stabilizeaza malurile si filtreaza apele incarcate cu nutrienti, avand rol important in fitoremediere. '
        'In trecut frunzele serveau la impletit cosuri, acoperisuri si rogojini, iar spicele decorative sunt culese si azi pentru aranjamente florale uscate.',
    imageAssets: ['assets/plants/typha_latifolia.jpg'],
  ),
  'urtica_dioica': PlantInfo(
    label: 'urtica_dioica',
    nameRo: 'Urzica',
    latin: 'Urtica dioica',
    status: 'LC',
    descriptionRo:
        'Urzica mare este una dintre plantele cu cea mai lunga istorie de utilizare de catre om, '
        'o perena viguroasa din familia Urticaceae cu valente alimentare, textile si medicinale. '
        'Tulpinile patrunghiulare (60–150 cm) si frunzele oval-cordate sunt acoperite cu peri urticanti ce injecteaza '
        'acid formic, histamina si serotonina la contact, provocand o senzatie de arsura. '
        'Florile mici, verzui, sunt dispuse in panicule suspendate; planta este dioica, cu sexe separate. '
        'Indica soluri bogate in azot si fosfor. Frunzele tinere sunt bogate in fier, vitamina C si proteine; '
        'se consuma fierte in supe, ciorbe si umpluturi pentru placinte. '
        'Extractele sunt utilizate in tratamentul artritei, al problemelor prostatei si ca tonic capilar in cosmetica.',
    imageAssets: ['assets/plants/urtica_dioica.jpg'],
  ),
};

PlantInfo? getPlantInfo(String label) => plantInfoByLabel[label];

String getStatusLabelRo(String status) => plantStatusInfo[status]?.labelRo ?? status;

Color getStatusColor(String status) => plantStatusInfo[status]?.color ?? const Color(0xFF888888);

bool isRedListStatus(String status) => status != 'LC';