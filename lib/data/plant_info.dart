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
    this.descriptionRo = 'Descriere în curs de completare.',
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
  'EX': PlantStatusInfo(code: 'EX', labelRo: 'Dispărut', color: Color(0xFF000000)),
  'CR': PlantStatusInfo(code: 'CR', labelRo: 'Pericol critic', color: Color(0xFFCC0000)),
  'EN': PlantStatusInfo(code: 'EN', labelRo: 'Periclitat', color: Color(0xFFFF4500)),
  'VU': PlantStatusInfo(code: 'VU', labelRo: 'Vulnerabil', color: Color(0xFFFF8C00)),
  'NT': PlantStatusInfo(code: 'NT', labelRo: 'Aproape amenințat', color: Color(0xFFFFD700)),
  'LC': PlantStatusInfo(code: 'LC', labelRo: 'Specie obișnuită', color: Color(0xFF228B22)),
};

const Map<String, PlantInfo> plantInfoByLabel = {
  'aconitum_lasiostomum': PlantInfo(
    label: 'aconitum_lasiostomum',
    nameRo: 'Omag galben',
    latin: 'Aconitum lasiostomum',
    status: 'CR',
    descriptionRo:
        'Omagul galben este o plantă erbacee perenă din familia Ranunculaceae, endemică zonelor montane din Europa de Est și Caucaz. '
        'Atinge înălțimi de 60–120 cm, cu tulpini erecte acoperite de peri moi și frunze palmat-lobate, de culoare verde-închis, cu 5–7 lobi adânc divizați. '
        'Florile, de un galben-pal caracteristic, sunt grupate în raceme terminale dense și înfloresc în iulie–august. '
        'Ca toate speciile de Aconitum, planta este extrem de toxică — alcaloizii din rădăcină (în special aconitina) pot fi letali chiar și în cantități mici. '
        'În Moldova și România crește sporadic pe versanți nordici umezi, la marginea pădurilor de fag și molid, la altitudini de 700–1500 m. '
        'Principalele amenințări sunt defrișarea habitatelor montane, pășunatul intensiv și colectarea necontrolată.',
    imageAssets: ['assets/plants/aconitum_lasiostomum.jpg'],
  ),
  'anemone_sylvestris': PlantInfo(
    label: 'anemone_sylvestris',
    nameRo: 'Anemonă de pădure',
    latin: 'Anemone sylvestris',
    status: 'VU',
    descriptionRo:
        'Anemona de pădure este o plantă erbacee perenă din familia Ranunculaceae, larg răspândită în Europa Centrală și de Est, '
        'însă în declin vizibil din cauza pierderii habitatelor. Formează colonii mici în poieni, liziere și păduri rare de stejar sau carpen, '
        'preferând solurile calcaroase bine drenate. Tulpinile florale ating 15–40 cm înălțime și poartă câte o singură floare albă '
        'cu 5 petale și un disc central galben-auriu; înflorește în aprilie–mai, imediat după topirea zăpezii. '
        'Frunzele bazale sunt trilobate și păroase, creând un covor verde după fructificare, iar fructele sunt achene cu puf alb mătăsos, purtate de vânt. '
        'Specia este sensibilă la intensificarea agriculturii, la închiderea pădurilor și la recoltarea florilor pentru buchete.',
    imageAssets: ['assets/plants/anemone_sylvestris.jpg'],
  ),
  'buttercup_flower': PlantInfo(
    label: 'buttercup_flower',
    nameRo: 'Piciorul cocoșului',
    latin: 'Ranunculus spp.',
    status: 'LC',
    descriptionRo:
        'Piciorul cocoșului este numele generic pentru ranunculele cu flori galbene lucioase, frecvente în pășuni și poieni umede. '
        'Tulpinile subțiri, ramificate, ating 20–50 cm, iar florile de 2–3 cm au petale cerate care reflectă intens lumina. '
        'Frunzele pot fi palmato-sectate la bază și mai înguste pe tulpină, iar plantele conțin suc acru și iritant. '
        'Se înmulțesc ușor prin semințe și rizomi scurți, formând deseori covoare în zonele cu sol umed primăvara. '
        'Deși sunt frumoase, părțile verzi sunt toxice pentru animale dacă sunt ingerate în stare proaspătă.',
    imageAssets: ['assets/plants/buttercup_flower.jpg'],
  ),
  'campanula_sibirica': PlantInfo(
    label: 'campanula_sibirica',
    nameRo: 'Clopotel siberian',
    latin: 'Campanula sibirica',
    status: 'EN',
    descriptionRo:
        'Clopotelul siberian este o plantă bienală sau perenă scurtă din familia Campanulaceae, caracteristică stepelor și pajiștilor uscate '
        'din Europa de Est, Siberia și Asia Centrală. Tulpinile rigide, păroase, ating 20–50 cm, cu frunze lanceolate aspre. '
        'Florile sunt tubular-campanulate, de un albastru-violet intens, grupate în cime cu ramuri scurte; înflorește din iunie până în august. '
        'Specia preferă soluri calcaroase sau nisipoase, bine expuse la soare. '
        'În Moldova este consemnată pe pantele uscate din sudul țării și pe marginile de drum neperturbate. '
        'Declinul său este cauzat de aratul pajiștilor naturale, de invazia speciilor adventive și de încetarea cosirilor tradiționale '
        'care mențineau habitatul deschis.',
    imageAssets: ['assets/plants/campanula_sibirica.jpg'],
  ),
  'centaurea_cyanus': PlantInfo(
    label: 'centaurea_cyanus',
    nameRo: 'Albăstrele',
    latin: 'Centaurea cyanus',
    status: 'LC',
    descriptionRo:
        'Albăstrelele sunt plante anuale sau bienale din familia Asteraceae, odinioară omniprezente în câmpurile de grâu, acum mai rare '
        'din cauza erbicidelor moderne. Tulpinile, de 30–80 cm, sunt ramificate și ușor făinoase, cu frunze înguste, lanceolate. '
        'Floricele albastre-cobalt, grupate în capitule de 2–3 cm, înfloresc din mai până în septembrie. '
        'Preferă soluri aerate, sărace și bine drenate, fără umiditate excesivă. '
        'Sunt plante melifere valoroase și gazde pentru diverse insecte, inclusiv bondari. '
        'În trecut serveau ca indicatori ai solurilor fertile nearate cu erbicide; astăzi sunt recultivate intenționat '
        'în grădini rustice și pe marginile câmpurilor ca benzi florale pentru biodiversitate.',
    imageAssets: ['assets/plants/centaurea_cyanus.jpg'],
  ),
  'chrysanthemum_x_morifolium': PlantInfo(
    label: 'chrysanthemum_x_morifolium',
    nameRo: 'Crizantemă',
    latin: 'Chrysanthemum x morifolium',
    status: 'LC',
    descriptionRo:
        'Crizantema de grădină este un hibrid complex din familia Asteraceae, obținut din specii asiatice și cultivat de peste 2500 de ani. '
        'Formele moderne includ mii de soiuri cu flori simple, pompon, sferic, anemoniforme sau în formă de lingură, '
        'în paletă cromatică completă exceptând albastrul. Înflorește toamna (septembrie–noiembrie), când ziua scade sub 12 ore, '
        'fiind o plantă de zi scurtă. Tulpinile ating 30–90 cm, cu frunze adânc lobate și aromate la frecare. '
        'Este plantă perenă rezistentă la brumă ușoară, dar sensibilă la îngheț puternic și la umezeala excesivă la rădăcină. '
        'În horticultură este apreciată atât ca floare de grădină, cât și ca floare tăiată cu durată lungă în vază.',
    imageAssets: ['assets/plants/chrysanthemum_x_morifolium.png'],
  ),
  'colchicum_autumnale': PlantInfo(
    label: 'colchicum_autumnale',
    nameRo: 'Brândușă de toamnă',
    latin: 'Colchicum autumnale',
    status: 'NT',
    descriptionRo:
        'Brândușa de toamnă este o plantă bulboasă perenă din familia Colchicaceae, prezentă în fânețele umede și poienile de câmpie '
        'din Europa Centrală și de Sud-Est. Florile roz-liliachii, cu șase tepale și fără frunze, apar direct din sol în august–octombrie, '
        'ceea ce i-a adus porecla "fiul fără tată". Frunzele, mari și lucioase, se dezvoltă abia în primăvara următoare, '
        'odată cu capsulele fructifere. Întreaga plantă — bulb, frunze, flori, semințe — conține colchicina, '
        'un alcaloid puternic toxic, folosit totuși în medicină pentru tratamentul gutei și în cercetarea genetică. '
        'Pășunatul excesiv și drenarea terenurilor umede reprezintă principalele pericole pentru această specie.',
    imageAssets: ['assets/plants/colchicum_autumnale.jpg'],
  ),
  'convallaria_majalis': PlantInfo(
    label: 'convallaria_majalis',
    nameRo: 'Lăcrămioare',
    latin: 'Convallaria majalis',
    status: 'EN',
    descriptionRo:
        'Lăcrămioarele sunt plante rizomatoase perene din familia Asparagaceae, ocrotite prin lege în multe țări europene. '
        'Cresc în păduri umbroase de foioase, pe soluri acide, humoase și bine umede, formând uneori covoare extinse. '
        'Două frunze mari, oval-lanceolate și lucioase, cuprind în primăvară (mai–iunie) o tulpină florală scurtă '
        'cu 5–12 clopote albi, globuloși, cu un parfum intens și inconfundabil. Fructele sunt bobițe roșii-cărămizii, toxice. '
        'Toate părțile plantei conțin glicozide cardiotonice (convalatoxina, convalozida) care o fac extrem de periculoasă dacă este ingerată. '
        'Culegerea masivă pentru floristică și comercializarea ilegală sunt principalele amenințări în România și Moldova.',
    imageAssets: ['assets/plants/convallaria_majalis.jpg'],
  ),
  'dianthus_carthusianorum': PlantInfo(
    label: 'dianthus_carthusianorum',
    nameRo: 'Garoafă de stepă',
    latin: 'Dianthus carthusianorum',
    status: 'NT',
    descriptionRo:
        'Garoafa de stepă este o plantă erbacee perenă din familia Caryophyllaceae, emblematică pentru pajiștile continentale uscate. '
        'Tulpinile subțiri, erecte (20–45 cm), poartă la vârf 3–20 flori de un roz-carmin strălucitor, grupate într-un capat dens. '
        'Petalele au marginea dințelată caracteristică genului Dianthus, iar caliciul este înconjurat de bractee brune, lungi. '
        'Înflorește din mai până în septembrie. Specia preferă soluri sărace în nutrienți, alcaline sau neutre, '
        'în zone deschise și însorite: pajiști xerofile, margini de cale ferată și taluzuri. '
        'Este sensibilă la îngrășarea solului, la înmulțirea arborilor și la cosirile prea timpurii sau prea frecvente.',
    imageAssets: ['assets/plants/dianthus_carthusianorum.jpg'],
  ),
  'fritillaria_ruthenica': PlantInfo(
    label: 'fritillaria_ruthenica',
    nameRo: 'Fritilarie rusă',
    latin: 'Fritillaria ruthenica',
    status: 'CR',
    descriptionRo:
        'Fritilaria rusă este o specie bulboasă din familia Liliaceae, deosebit de rară și amenințată critic pe teritoriul Moldovei și României. '
        'Bulbii sunt mici, alb-gălbui, cu solzi numeroși. Tulpina (20–50 cm) este zveltă, cu frunze liniare alterne '
        'și câteva în vârf răsucite în cârcei, ceea ce ajută planta să se sprijine printre ierburi înalte. '
        'Florile în formă de clopot, brun-oliv cu rețea de pătrățele verzui, atârnă solitare sau în grupuri de 2–3 '
        'și înfloresc în aprilie–mai. Preferă luncile umede, pajiștile de luncă și lizierele cu vegetație bogată. '
        'Este extrem de vulnerabilă la drenarea terenurilor inundabile, la defrișare și la colectarea ilegală a bulbilor.',
    imageAssets: ['assets/plants/fritillaria_ruthenica.jpg'],
  ),
  'galanthus_nivalis': PlantInfo(
    label: 'galanthus_nivalis',
    nameRo: 'Ghiocel',
    latin: 'Galanthus nivalis',
    status: 'CR',
    descriptionRo:
        'Ghiocelul este cel mai cunoscut mesager al primăverii, o plantă bulboasă mică din familia Amaryllidaceae. '
        'Bulbul oval produce primăvara devreme (ianuarie–martie) două frunze liniare, albastru-verzui, '
        'și o tulpină florală de 7–15 cm cu un singur clopot alb pendent, alcătuit din 3 tepale externe '
        'și 3 tepale interne cu o pată verde caracteristică la vârf. '
        'Crește spontan în păduri de foioase umede, în lunci și poieni, preferând soluri bogate și semiumbroase. '
        'Este ocrotit prin lege în România și Moldova: culegerea, comercializarea și exportul sunt interzise. '
        'Populațiile naturale sunt amenințate de culegerea masivă în scop ornamental, de pierderea pădurilor riverane '
        'și de compactarea solului prin pășunatul în zone de pădure.',
    imageAssets: ['assets/plants/galanthus_nivalis.jpg'],
  ),
  'glechoma_hederacea': PlantInfo(
    label: 'glechoma_hederacea',
    nameRo: 'Lumânărică pământului',
    latin: 'Glechoma hederacea',
    status: 'LC',
    descriptionRo:
        'Lumânărica pământului este o plantă perenă târâtoare din familia Lamiaceae, cu tulpini pătrunghiulare '
        'ce se înrădăcinează la noduri și formează rapid covoare dese. Frunzele reniforme, cu marginea crenat-dențată, '
        'emit un miros puternic aromat la strivire. Florile bilobate, liliachiu-albastre, cu puncte violet în interior, '
        'apar în martie–iunie și sunt deosebit de atractive pentru albine, oferind nectar și polen timpuriu. '
        'Crește în grădini, pe margini de drumuri, în garduri și păduri umbroase. '
        'Este utilizată tradițional în fitoterapie ca infuzie pentru tuse și afecțiuni bronhice '
        'și ca plantă aromatică culinară în unele bucătării regionale.',
    imageAssets: ['assets/plants/glechoma_hederacea.jpg'],
  ),
  'Hyacinth_flower': PlantInfo(
    label: 'Hyacinth_flower',
    nameRo: 'Zambilă de grădină',
    latin: 'Hyacinthus orientalis',
    status: 'LC',
    descriptionRo:
        'Zambila este o plantă bulboasă perenă îndrăgită pentru inflorescentele parfumate de primăvară. '
        'Bulbul produce frunze liniare, lucioase, și o tulpină florală de 15–25 cm cu un racem dens de flori tubulare cerate. '
        'Soiurile horticole acoperă toată gama cromatică: alb, roz, mov, albastru intens sau bicolor. '
        'Se plantează toamna în sol bine drenat, bogat în humus, necesitând o perioadă de frig pentru a înflori abundent. '
        'Toate părțile conțin oxalați și pot fi iritante la ingerare, de aceea se manevrează cu mănuși la plantare.',
    imageAssets: ['assets/plants/Hyacinth_flower.png'],
  ),
  'helianthus_annuus': PlantInfo(
    label: 'helianthus_annuus',
    nameRo: 'Floarea-soarelui',
    latin: 'Helianthus annuus',
    status: 'LC',
    descriptionRo:
        'Floarea-soarelui este o plantă anuală originară din America de Nord, cultivată la scară mondială pentru semințele oleaginoase. '
        'Tulpina robustă, aspră, poate atinge 1,5–3 m înălțime, cu frunze mari, cordate, ușor aspre la pipăit. '
        'Capitulul floral poate depăși 30 cm în diametru la soiurile agricole; florile externe sunt ligulate și sterile (galbene), '
        'cele centrale tubulare și fertile. Tinerețea capitulului urmărește mișcarea soarelui (heliotropism), '
        'dar la maturitate rămâne orientat spre est. '
        'Moldova este unul dintre principalii producători regionali de floarea-soarelui, cultura ocupând suprafețe agricole extinse. '
        'Există și soiuri ornamentale cu flori duble sau în tonuri de bronz, portocaliu și maro, populare în grădini.',
    imageAssets: ['assets/plants/helianthus_annuus.jpg'],
  ),
  'hyssopus_officinalis': PlantInfo(
    label: 'hyssopus_officinalis',
    nameRo: 'Isop',
    latin: 'Hyssopus officinalis',
    status: 'LC',
    descriptionRo:
        'Isopul este un subarbust semipersistent aromat din familia Lamiaceae, originar din bazinul mediteranean și Asia Centrală. '
        'Tulpinile lemnoase la bază ating 20–60 cm, cu frunze liniare, glandulos-punctate, intens aromate. '
        'Florile tubulare, bilobate, de culoare albastru-violet (rar roz sau albe), sunt grupate în spice unilaterale '
        'și înfloresc din iulie până în septembrie, atrăgând masiv albinele. '
        'Este una dintre cele mai vechi plante medicinale și condimentare cunoscute, menționată în textele biblice. '
        'Uleiul esențial este expectorant și antiseptic; se folosește la aromatizarea unor lichioruri renumite '
        'și ca condiment în bucătăria mediteraneană. Preferă soluri calcaroase, uscate, în poziții sudice și însorite.',
    imageAssets: ['assets/plants/hyssopus_officinalis.jpg'],
  ),
  'iris': PlantInfo(
    label: 'iris',
    nameRo: 'Iris de grădină',
    latin: 'Iris germanica',
    status: 'LC',
    descriptionRo:
        'Irisul de grădină este un grup de hibrizi pereni rizomatoși renumiți pentru florile mari, catifelate, cu barbă colorată pe petalele externe. '
        'Tulpinile înalte de 40–90 cm poartă de obicei 3–6 flori în mai–iunie, într-o paletă variată de la alb și galben până la violet închis sau bicolor. '
        'Frunzele sunt în evantai, asemănătoare cu ale sabiei, persistente peste iarnă în regiunile mai blânde. '
        'Preferința pentru soluri bine drenate și expunere solară directă le face potrivite pentru borduri și straturi înălțate. '
        'Divizarea rizomilor la 3–4 ani menține tufele aerisite și reduce riscul de putrezire.',
    imageAssets: ['assets/plants/iris_sibirica.jpg'],
  ),
  'iris_pumila': PlantInfo(
    label: 'iris_pumila',
    nameRo: 'Iris pitic',
    latin: 'Iris pumila',
    status: 'CR',
    descriptionRo:
        'Irisul pitic este cea mai mică specie de iris europeană (5–15 cm înălțime), aparținând familiei Iridaceae. '
        'Rizomul târâtor produce în aprilie–mai flori mari în raport cu talia plantei, de culoare violet-albăstruie până la galbenă sau albă, '
        'cu petale externe largi, catifelate, și o barbă galbenă caracteristică. '
        'Crește pe coaste nisipoase sau calcaroase stepice, în condiții de secetă pronunțată și ger intens. '
        'În Moldova este consemnat pe stâncării și pajiști de loess din sudul și centrul țării, '
        'dar populațiile s-au redus dramatic din cauza conversiei stepelor în terenuri agricole și a suprapășunatului. '
        'Este ocrotit prin Cartea Roșie a Republicii Moldova.',
    imageAssets: ['assets/plants/iris_pumila.jpg'],
  ),
  'iris_sibirica': PlantInfo(
    label: 'iris_sibirica',
    nameRo: 'Stânjănel siberian',
    latin: 'Iris sibirica',
    status: 'CR',
    descriptionRo:
        'Stânjănelul siberian este o plantă rizomatoasă viguroasă din familia Iridaceae, atingând 40–100 cm înălțime. '
        'Frunzele sunt înguste, lanceolate, formează smocuri dese de culoare verde-intensă. '
        'Florile, de un albastru-violet pur, cu venioare albe și galbene pe petalele externe, înfloresc în mai–iunie. '
        'Specia preferă pajiștile umede, marginile de bălți și cursurile de apă lente, pe soluri grele, temporar inundate. '
        'Este una dintre cele mai vulnerabile specii de luncă din Moldova: drenarea câmpurilor inundabile, '
        'regularizarea râurilor și cosirile prea timpurii au dus la dispariția majorității populațiilor cunoscute. '
        'Este inclusă în Cartea Roșie a Republicii Moldova și necesită protecție strictă a habitatelor de luncă.',
    imageAssets: ['assets/plants/iris_sibirica.jpg'],
  ),
  'iris_variegata': PlantInfo(
    label: 'iris_variegata',
    nameRo: 'Stânjănel de câmp variat',
    latin: 'Iris variegata',
    status: 'EN',
    descriptionRo:
        'Stânjănelul de câmp variat este endemic Balcanilor și Europei Centrale, răspândit pe pajiști uscate, coaste calcaroase '
        'și păduri de stejar rărefiete, la altitudini mici și medii. Tulpina (20–40 cm) poartă 2–3 flori cu petale externe '
        'galben-crem decorate cu rețea de vinișoare mov-violacee, iar petalele interne sunt albe sau gălbui. '
        'Această combinație cromatică distinctă îl face ușor de recunoscut în câmp. Înflorește în mai–iunie. '
        'Este amenințat de închiderea peisajului prin invazia tufișurilor după abandonarea pășunatului tradițional '
        'și de colectarea plantelor întregi din natură pentru grădini particulare.',
    imageAssets: ['assets/plants/iris_variegata.jpg'],
  ),
  'lamium_album': PlantInfo(
    label: 'lamium_album',
    nameRo: 'Urzicuță moartă albă',
    latin: 'Lamium album',
    status: 'LC',
    descriptionRo:
        'Urzicuța moartă albă este o plantă erbacee perenă din familia Lamiaceae, frecventă pe margini de drumuri, garduri, '
        'terenuri ruderale și liziere de pădure din întreaga Europă temperată. '
        'Seamănă frapant cu urzica adevărată — frunze oval-cordate, dintat-crenate, cu peri — dar nu are peri urticanți, '
        'de unde vine și denumirea populară de urzică moartă. '
        'Florile albe, cu două buze pronunțate, sunt dispuse în verticile axilare și înfloresc din mai până în septembrie. '
        'Sunt extrem de atractive pentru bondari și albine, care accesează nectarul din tubul corolei. '
        'Folosită în medicina populară ca hemostatic și antiinflamator; frunzele tinere sunt comestibile fierte.',
    imageAssets: ['assets/plants/lamium_album.jpg'],
  ),
  'lavandula_angustifolia': PlantInfo(
    label: 'lavandula_angustifolia',
    nameRo: 'Lavandă',
    latin: 'Lavandula angustifolia',
    status: 'LC',
    descriptionRo:
        'Lavanda este un subarbust peren aromat din familia Lamiaceae, originar din Mediterana, cultivat în toată lumea temperată '
        'pentru uleiul esențial, pentru frumusețea florilor și pentru rezistența remarcabilă la secetă. '
        'Tulpinile lemnoase la bază formează tufe rotunde de 30–60 cm, cu frunze înguste, gri-verzui, persistent aromate. '
        'Spicele florale, de 5–10 cm, sunt purpuriu-albastre și apar în iunie–august, atrăgând albinele în număr mare. '
        'Uleiul esențial, bogat în linalool și acetat de linalil, are proprietăți antiseptice, anxiolitice și calmante, '
        'folosite pe scară largă în aromoterapie, cosmetică și farmaceutică. '
        'Este și una dintre cele mai decorative plante pentru garduri vii joase și borduri în stil mediteranean.',
    imageAssets: ['assets/plants/lavandula_angustifolia.jpg'],
  ),
  'leucanthemum_vulgare': PlantInfo(
    label: 'leucanthemum_vulgare',
    nameRo: 'Margaretă',
    latin: 'Leucanthemum vulgare',
    status: 'LC',
    descriptionRo:
        'Margareta este una dintre cele mai cunoscute și iubite flori sălbatice din Europa, aparținând familiei Asteraceae. '
        'Planta perenă (20–60 cm) formează rozete bazale din care pornesc tulpini cu frunze lobate, spatulate la bază. '
        'Capitulele au un disc central galben și 20–30 ligule albe lungi, cu diametrul de 3–6 cm; înflorește mai–septembrie. '
        'Preferă fânețe, livezi și margini de drum cu sol bine drenat și pH neutru până la slab alcalin. '
        'Este tolerantă la cosit și reflorește rapid după tăiere, motiv pentru care s-a menținut bine '
        'în pajiștile tradițional cosite. Este o plantă meliferă importantă și gazdă pentru numeroase specii de fluturi și bondari.',
    imageAssets: ['assets/plants/leucanthemum_vulgare.jpg'],
  ),
  'lilium_martagon': PlantInfo(
    label: 'lilium_martagon',
    nameRo: 'Crin de pădure',
    latin: 'Lilium martagon',
    status: 'CR',
    descriptionRo:
        'Crinul de pădure este una dintre cele mai spectaculoase plante spontane din Europa, aparținând familiei Liliaceae. '
        'Bulbul galben-portocaliu produce o tulpină robustă de 50–150 cm, cu frunze dispuse în verticile. '
        'Florile, de culoare roz-liliachie cu puncte brun-închise și cu tepale puternic recurvate în formă de turban, '
        'atârnă în raceme de 5–20 exemplare și emană un parfum puternic, mai ales seara, pentru a atrage polenizatorii nocturni. '
        'Înflorește în iunie–iulie. Preferă păduri umbroase de fag și brad, cu humus abundent și umiditate constantă. '
        'Culegerea ilegală a florilor și dezrădăcinarea bulbilor pentru grădini sunt principalele cauze ale declinului său '
        'în Moldova, unde este ocrotit prin lege.',
    imageAssets: ['assets/plants/lilium_martagon.jpg'],
  ),
  'matricaria_chamomilla': PlantInfo(
    label: 'matricaria_chamomilla',
    nameRo: 'Mușețel',
    latin: 'Matricaria chamomilla',
    status: 'LC',
    descriptionRo:
        'Mușețelul este planta medicinală numărul unu în medicina tradițională europeană, o anuală sau bienală subțire (20–50 cm) '
        'din familia Asteraceae. Frunzele sunt fin divizate, până în segmente filiforme, creând un aspect aerisit. '
        'Capitulele cu disc galben convex și ligule albe reflexe înfloresc din mai până în septembrie. '
        'Receptaculul gol pe interior — caracter distinctiv față de speciile false — conține ulei esențial bogat '
        'în chamazulenă și bisabolol cu efect antiinflamator, antispasmodic și calmant. '
        'Crește pe soluri reavăne, arate sau deranjate: ogoare, margini de drum, șanțuri. '
        'În Moldova se cultivă și industrial, produsul principal fiind florile uscate pentru ceai și extracte farmaceutice.',
    imageAssets: ['assets/plants/matricaria_chamomilla.jpg'],
  ),
  'mentha_piperita': PlantInfo(
    label: 'mentha_piperita',
    nameRo: 'Mentă',
    latin: 'Mentha piperita',
    status: 'LC',
    descriptionRo:
        'Menta este un hibrid steril (Mentha aquatica × Mentha spicata) din familia Lamiaceae, reprodus exclusiv vegetativ '
        'prin stoloni și rizomi. Tulpinile pătrunghiulare, de 30–90 cm, cu frunze oval-lanceolate dintat-serificate, '
        'emană un miros intens mentolat la simpla atingere. '
        'Florile mici, liliachii-purpurii, sunt grupate în spice terminale și înfloresc iulie–septembrie. '
        'Crește viguroasă în orice sol umed și bogat, putând deveni invazivă rapid prin extindere rizomală. '
        'Uleiul esențial, bogat în mentol și mentonă, este folosit pe scară largă în farmaceutică, alimentație, '
        'cosmetică și aromoterapie. Moldova exportă cantități semnificative de mentol și ulei de mentă spre piața europeană.',
    imageAssets: ['assets/plants/mentha_piperita.jpg'],
  ),
  'muscari_neglectum': PlantInfo(
    label: 'muscari_neglectum',
    nameRo: 'Muscari neglijat',
    latin: 'Muscari neglectum',
    status: 'NT',
    descriptionRo:
        'Muscari neglijat este o mică plantă bulboasă de primăvară din familia Asparagaceae, frecvent confundată cu specii înrudite. '
        'Bulbii albicioși produc în martie–mai 4–6 frunze liniare, semirigide, și tulpini florale de 10–20 cm '
        'cu inflorescente dense în formă de strugure: florile inferioare sunt albastru-închis, aproape negricioase, '
        'cele superioare mai deschise la culoare și sterile. '
        'Colonizează pajiști uscate, vii abandonate, coaste cu vegetație rară și liziere de pădure, pe soluri sărace. '
        'În Moldova este încă relativ frecvent în zone neperturbate, însă aratura și utilizarea erbicidelor '
        'reduc constant populațiile naturale.',
    imageAssets: ['assets/plants/muscari_neglectum.jpg'],
  ),
  'narcissus_pseudonarcissus': PlantInfo(
    label: 'narcissus_pseudonarcissus',
    nameRo: 'Narcisă',
    latin: 'Narcissus pseudonarcissus',
    status: 'LC',
    descriptionRo:
        'Narcisa sălbatică este o plantă bulboasă perenă din familia Amaryllidaceae, nativă în Europa de Vest, '
        'naturalizată și cultivată pe scară largă în toată Europa temperată. '
        'Bulbii tunicați produc primăvara (martie–mai) 2–3 frunze glauce liniare și o tulpină florală de 20–40 cm '
        'cu o singură floare mare: coroana (trompeta) galbenă lungă, înconjurată de 6 tepale galbene mai deschise. '
        'În pajiști naturale umede poate forma covoare spectaculoase de culoare galbenă. '
        'Toate părțile conțin alcaloizi narcicladini puternic toxici dacă sunt ingerați; sucul bulbilor poate irita pielea. '
        'Soiurile horticole, mult mai variate cromatic, sunt printre cele mai populare bulboase de grădină din lume.',
    imageAssets: ['assets/plants/narcissus_pseudonarcissus.jpg'],
  ),
  'nuphar_lutea': PlantInfo(
    label: 'nuphar_lutea',
    nameRo: 'Nufăr galben',
    latin: 'Nuphar lutea',
    status: 'VU',
    descriptionRo:
        'Nufărul galben este o plantă acvatică perenă din familia Nymphaeaceae, cu rizom gros, cărnoase, fixat în nămol '
        'la adâncimi de 0,5–3 m. Frunzele plutitoare, oval-eliptice, ating 25–40 cm lungime, cu nervuri proeminente '
        'pe fața inferioară; există și frunze submerse, subțiri și transparente. '
        'Florile globuloase, galbene, cu diametrul de 4–6 cm, stau deasupra apei pe pedunculi rigizi '
        'și înfloresc din mai până în august, cu un miros slab alcoolic specific. '
        'Indică ape curate, cu mișcare lentă, în râuri, lacuri și bălți. '
        'Poluarea apelor, regularizarea albiilor, colmatarea și culegerea florilor constituie principalele amenințări.',
    imageAssets: ['assets/plants/nuphar_lutea.jpg'],
  ),
  'nymphaea_alba': PlantInfo(
    label: 'nymphaea_alba',
    nameRo: 'Nufăr alb',
    latin: 'Nymphaea alba',
    status: 'CR',
    descriptionRo:
        'Nufărul alb este simbolul apelor curate și liniștite, una dintre cele mai frumoase plante acvatice spontane din Europa. '
        'Rizomul puternic, înnodat, se fixează în malul lacurilor și bălților pe adâncimi de 1–3 m. '
        'Frunzele circulare, cu un sinus adânc, plutesc la suprafață și pot atinge 30 cm în diametru. '
        'Florile albe, cu 20–25 petale dispuse în spirală și un disc de stamine galbene, înfloresc din mai până în septembrie, '
        'închizându-se seara și redeschizându-se dimineața. '
        'Specia este extrem de sensibilă la poluare și la perturbarea mecanică a fundului apei. '
        'În Moldova populațiile naturale au scăzut dramatic; este protejată prin lege și inclusă în Cartea Roșie a Republicii Moldova.',
    imageAssets: ['assets/plants/nymphaea_alba.jpg'],
  ),
  'paeonia_tenuifolia': PlantInfo(
    label: 'paeonia_tenuifolia',
    nameRo: 'Bujor de stepă',
    latin: 'Paeonia tenuifolia',
    status: 'CR',
    descriptionRo:
        'Bujorul de stepă este una dintre cele mai rare și mai ocrotite plante din Moldova, simbol al patrimoniului natural național. '
        'Spre deosebire de bujorul de pădure, are frunzele fin-sectate până în segmente filiforme, creând un aspect dantelos distinctiv. '
        'Florile solitare, roșii-strălucitoare, cu 5 petale late și un mănunchi de stamine galbene, înfloresc spectaculos în mai. '
        'Crește exclusiv pe stepe ierboase native, pe coaste cu iarbă scurtă și sol superficial. '
        'A dispărut din marea majoritate a localităților istorice din cauza araturii stepelor, suprapășunatului și colectării ilegale. '
        'Rezervația "Plaiul Fagului" și câteva arii protejate din sudul Moldovei adăpostesc ultimele populații viabile.',
    imageAssets: ['assets/plants/paeonia_tenuifolia.jpg'],
  ),
  'papaver_rhoeas': PlantInfo(
    label: 'papaver_rhoeas',
    nameRo: 'Mac de câmp',
    latin: 'Papaver rhoeas',
    status: 'LC',
    descriptionRo:
        'Macul de câmp este una dintre florile sălbatice cu cea mai bogată încărcătură culturală și simbolică din Europa, '
        'o anuală din familia Papaveraceae. Tulpinile (20–80 cm), păroase și ramificate, poartă flori solitare de 5–9 cm '
        'cu petale roșii-strălucitoare și o pată neagră bazală; înflorește mai–iulie. '
        'Capsulele fructifere conțin mii de semințe minuscule care pot rămâne viabile în sol 40–80 de ani, '
        'germinând masiv după arătură sau deranjarea solului. '
        'Nu conține morfină (spre deosebire de Papaver somniferum), ci alcaloizi mai puțin puternici. '
        'Odinioară simbol al lanurilor de grâu, a dispărut din câmpurile tratate cu erbicide, '
        'însă revine în grădini de tip wildflower și în câmpurile de agricultură ecologică.',
    imageAssets: ['assets/plants/papaver_rhoeas.jpg'],
  ),
  'petunia_x_hybrida': PlantInfo(
    label: 'petunia_x_hybrida',
    nameRo: 'Petunie',
    latin: 'Petunia x hybrida',
    status: 'LC',
    descriptionRo:
        'Petuniile sunt plante anuale semitârâtoare sau erecte din familia Solanaceae, hibridate din specii sud-americane. '
        'Produc un afișaj floral spectaculos și aproape neîntrerupt din mai până la brumă, în orice culoare imaginabilă, '
        'inclusiv dungi, borduri și forme duble. Tulpinile sunt vâscoase la atingere, cu peri glanduloși, '
        'ajungând la 20–60 cm lungime. '
        'Sunt ideale pentru ghivece suspendate, jardiniere de balcon și borduri de grădină. '
        'Există trei categorii principale: Grandiflora (flori mari, mai sensibile la ploaie), '
        'Multiflora (flori medii, rezistente) și Milliflora (compacte, cu flori mici și foarte numeroase). '
        'Nu rezistă la îngheț și se tratează ca anuale în clima temperată.',
    imageAssets: ['assets/plants/petunia_x_hybrida.png'],
  ),
  'plantago_lanceolata': PlantInfo(
    label: 'plantago_lanceolata',
    nameRo: 'Pătlagină îngustă',
    latin: 'Plantago lanceolata',
    status: 'LC',
    descriptionRo:
        'Pătlagina îngustă este o plantă erbacee perenă din familia Plantaginaceae, răspândită în toată lumea temperată '
        'ca buruiană rezistentă, dar și ca plantă medicinală valoroasă. '
        'Frunzele lanceolate, cu 3–5 nervuri paralele proeminente, formează o rozetă bazală compactă. '
        'Tulpinile florale de 20–50 cm se termină cu un spic cilindric dens de flori verzui-albicioase cu antere violete. '
        'Polenul său este un alergen major în aer primăvară–vară. '
        'Frunzele conțin aucubină (iridoid glicozid) și mucilaje cu efect antiinflamator și cicatrizant, '
        'folosite tradițional în comprese pentru răni, înțepături de insecte și afecțiuni ale căilor respiratorii.',
    imageAssets: ['assets/plants/plantago_lanceolata.jpg'],
  ),
  'platanthera_bifolia': PlantInfo(
    label: 'platanthera_bifolia',
    nameRo: 'Orhidee cu două frunze',
    latin: 'Platanthera bifolia',
    status: 'EN',
    descriptionRo:
        'Platanthera bifolia este o orhidee terestră nativă din familia Orchidaceae, una dintre cele mai elegante plante sălbatice europene. '
        'Denumirea vine de la cele două frunze bazale mari, oval-eliptice și lucioase, dispuse opus la baza tulpinii. '
        'Tulpina florală (20–45 cm) poartă un racem dens cu 15–30 flori albe, cu un pinten lung și subțire, '
        'parfumate intens noaptea pentru a atrage fluturii nocturni polenizatori. Înflorește în mai–iulie '
        'în fânețe bogate și luminișuri de pădure cu sol calcaros. '
        'Este strict protejată; culegerea este interzisă prin lege. '
        'Principalele amenințări sunt fertilizarea agricolă, care favorizează iarba grasă ce suprimă planta, '
        'și abandonarea cosirilor tradiționale care mențineau habitatele deschise.',
    imageAssets: ['assets/plants/platanthera_bifolia.jpg'],
  ),
  'ranunculus_acris': PlantInfo(
    label: 'ranunculus_acris',
    nameRo: 'Piciorul cocoșului de pajiște',
    latin: 'Ranunculus acris',
    status: 'LC',
    descriptionRo:
        'Ranunculus acris este o specie perenă foarte răspândită în pășuni, livezi și margini de drum, recunoscută după florile galbene strălucitoare. '
        'Tulpinile ușor păroase pot atinge 30–80 cm, iar frunzele bazale sunt palmato-sectate, cu lobi adânc crestat. '
        'Înflorește din mai până în iulie, fiecare tulpină purtând mai multe flori de 2–3 cm cu petale lucioase. '
        'Sucul proaspăt este iritant și poate provoca leziuni pe piele sau în gura animalelor, însă planta își pierde toxicitatea după uscare în fân. '
        'Prezența ei indică de obicei soluri umede și moderat bogate în nutrienți.',
    imageAssets: ['assets/plants/ranunculus_acris.png'],
  ),
  'rosa_x_hybrida': PlantInfo(
    label: 'rosa_x_hybrida',
    nameRo: 'Trandafir de grădină',
    latin: 'Rosa x hybrida',
    status: 'LC',
    descriptionRo:
        'Trandafirul de grădină este regele ornamentalelor, un hibrid complex din familia Rosaceae, cu mii de soiuri clasificate în grupe: '
        'hibrizi de ceai (flori mari solitare), floribunde (buchete dense), urcători, miniatură și altele. '
        'Înflorește din mai până în noiembrie, cu vârf în iunie și septembrie, cu flori puternic parfumate '
        'în paleta cromatică completă. Tulpinile sunt acoperite cu ghimpi de mărimi variate, iar frunzele sunt penate, '
        'lucios-verzi. Fructele (măceșele) sunt bogate în vitamina C și folosite în ceaiuri și dulcețuri. '
        'Este ornamentala cu cea mai lungă istorie culturală și simbolică din lume, cultivată de peste 5000 de ani.',
    imageAssets: ['assets/plants/rosa_x_hybrida.jpg'],
  ),
  'scilla_siberica': PlantInfo(
    label: 'scilla_siberica',
    nameRo: 'Viorele (scilă)',
    latin: 'Scilla siberica',
    status: 'NT',
    descriptionRo:
        'Viorelele sunt mici plante bulboase de primăvară din familia Asparagaceae, originare din Asia Mică și sudul Rusiei, '
        'naturalizate în Europa Centrală și de Est. Bulbii mici produc 2–4 frunze liniare și tulpini florale de 10–20 cm '
        'cu 1–5 flori albastre-cobalt, patente, ce apar în martie–aprilie, de obicei înaintea frunzelor copacilor. '
        'Colonizează pante umede, poieni de pădure și pajiști semi-umbrite. '
        'Sunt rezistente la îngheț și tolerează umbra variabilă, înmulțindu-se natural prin semințe și bulbili, '
        'formând în timp colonii extinse. Deși încă frecvente în unele zone, sunt amenințate de urbanizare '
        'și de culegerea excesivă pentru buchete de primăvară.',
    imageAssets: ['assets/plants/scilla_siberica.jpg'],
  ),
  'silybum_marianum': PlantInfo(
    label: 'silybum_marianum',
    nameRo: 'Ciulin (armurariu)',
    latin: 'Silybum marianum',
    status: 'LC',
    descriptionRo:
        'Armurarul este o plantă bienală impunătoare din familia Asteraceae, originară din Mediterana, naturalizată în Moldova și România. '
        'În primul an formează o rozetă de frunze mari, lucioase, verzi cu pete albe și nervuri, cu margini puternic spinoase. '
        'În al doilea an tulpina (60–150 cm) poartă capitule solitare, rotunde, de 4–7 cm, '
        'cu flori purpuriu-violet și bractee terminate în spini puternici. '
        'Achenele conțin silimarina, un complex de flavonoliganani cu efect hepatoprotector demonstrat clinic, '
        'larg folosit în tratamentul hepatitelor și cirozei. '
        'Crește pe terenuri ruderale, margini de drum și pante uscate, fiind remarcabil de rezistent la secetă și la îngheț.',
    imageAssets: ['assets/plants/silybum_marianum.jpg'],
  ),
  'taraxacum_officinale': PlantInfo(
    label: 'taraxacum_officinale',
    nameRo: 'Păpădie',
    latin: 'Taraxacum officinale',
    status: 'LC',
    descriptionRo:
        'Păpădia este una dintre cele mai comune plante spontane din zonele temperate, recunoscută după rozeta de frunze zimțate și capitulele galbene. '
        'Tulpina florală goală la interior atinge 10–40 cm și secretă un latex alb, amar. '
        'Înflorește din aprilie până toamna, iar fructele cu papus se răspândesc ușor prin vânt, colonizând rapid solurile deranjate. '
        'Frunzele tinere sunt comestibile în salate, iar rădăcinile uscate se folosesc în infuzii cu efect diuretic și digestiv. '
        'Tolerează tasarea și sărăcirea solului, motiv pentru care apare frecvent în gazon, parcuri și pe margini de drum.',
    imageAssets: ['assets/plants/taraxacum_officinale.png'],
  ),
  'tulipa_biebersteiniana': PlantInfo(
    label: 'tulipa_biebersteiniana',
    nameRo: 'Lalea sălbatică Bieberstein',
    latin: 'Tulipa biebersteiniana',
    status: 'CR',
    descriptionRo:
        'Laleaua sălbatică Bieberstein este o specie mică și rară din familia Liliaceae, endemică stepelor pontice și a Crimeii. '
        'Bulbii mici, cu tunici brune, produc în aprilie–mai 2–3 frunze liniare glauce și o tulpină florală de 10–30 cm '
        'cu o singură floare galben-aurie strălucitoare, cu petale externe roșii pe dos. '
        'Crește pe coaste pietroase sau stâncării calcaroase expuse la soare, în asociații stepice native. '
        'În Moldova este extrem de rară, cu populații izolate în sudul țării. '
        'Este amenințată critic de distrugerea habitatelor stepice, de suprapășunat și de colectarea bulbilor și a florilor '
        'de către colecționari și turiști.',
    imageAssets: ['assets/plants/tulipa_gesneriana.jpg'],
  ),
  'tulipa_gesneriana': PlantInfo(
    label: 'tulipa_gesneriana',
    nameRo: 'Lalea de grădină',
    latin: 'Tulipa gesneriana',
    status: 'LC',
    descriptionRo:
        'Laleaua de grădină este cel mai popular simbol al primăverii, un hibrid horticol complex din familia Liliaceae, '
        'derivat din specii anatoliene și centro-asiatice, cultivat și perfecționat de secole în Olanda și Turcia. '
        'Mii de soiuri sunt clasificate în 15 clase oficiale: simple timpurii, duble, papagal, fimbriate, viridiflora și altele. '
        'Înfloresc în funcție de soi între martie și mai, cu flori în orice culoare exceptând albastrul pur. '
        'Bulbii au nevoie obligatorie de o perioadă de frig (vernalizare) pentru a înflori, motiv pentru care se plantează toamna. '
        'După înflorire frunzișul se îngălbenește treptat în 6 săptămâni, timp în care bulbul își acumulează rezervele pentru sezonul următor.',
    imageAssets: ['assets/plants/tulipa_gesneriana.jpg'],
  ),
  'typha_latifolia': PlantInfo(
    label: 'typha_latifolia',
    nameRo: 'Papură',
    latin: 'Typha latifolia',
    status: 'LC',
    descriptionRo:
        'Papura este o plantă erbacee acvatică perenă din familia Typhaceae, dominantă la marginea lacurilor, bălților '
        'și râurilor cu curgere lentă din întreaga emisferă nordică. '
        'Tulpinile cilindrice, fără noduri, ating 1,5–3 m înălțime, cu frunze liniare late (1–2 cm) și nervuri paralele. '
        'Inflorescentele sunt caracteristice: un cilindru compact brun-închis (spicul femel, de 10–20 cm) '
        'deasupra căruia stă un spic mascul galben care eliberează nori de polen la maturitate. '
        'Rizomii puternici stabilizează malurile și filtrează apele încărcate cu nutrienți, având rol important în fitoremediere. '
        'În trecut frunzele serveau la împletit coșuri, acoperișuri și rogojini, iar spicele decorative sunt culese și azi pentru aranjamente florale uscate.',
    imageAssets: ['assets/plants/typha_latifolia.jpg'],
  ),
  'valeriana_officinalis': PlantInfo(
    label: 'valeriana_officinalis',
    nameRo: 'Odolean (valeriană)',
    latin: 'Valeriana officinalis',
    status: 'LC',
    descriptionRo:
        'Valeriana este o plantă erbacee perenă din zonele umede, recunoscută pentru rizomii puternic aromați cu efect sedativ. '
        'Tulpinile robuste pot depăși 1–1,5 m, cu frunze opuse penate și cu inflorescente corimbiforme de flori roz-pal sau albe, parfumate, în mai–iulie. '
        'Rizomii uscați conțin valepotriați și acid valerianic, folosiți în tincturi și ceaiuri pentru insomnie și anxietate. '
        'Preferă soluri reavăne, bogate în materie organică, pe maluri de râu, margini de mlaștini și fânețe umede, unde poate forma colonii dense. '
        'Recoltarea excesivă din flora spontană trebuie controlată pentru a proteja populațiile locale.',
    imageAssets: ['assets/plants/valeriana_officinalis.png'],
  ),
  'viola_odorata': PlantInfo(
    label: 'viola_odorata',
    nameRo: 'Toporași parfumați',
    latin: 'Viola odorata',
    status: 'LC',
    descriptionRo:
        'Toporașii parfumați sunt plante mici, perene, cu tulpini târâtoare și frunze cordate, lucioase, adunate în rozete la nivelul solului. '
        'Florile apar foarte devreme, din februarie până în aprilie, sunt violet închis sau albe și au un parfum intens dulceag. '
        'Planta preferă semiumbra pădurilor de foioase, grădinile umbroase și marginile de alei, unde formează rapid covor verde. '
        'Petalele și frunzele tinere sunt comestibile în salate, iar siropul de toporași era folosit tradițional ca expectorant ușor. '
        'Este ușor de naturalizat în peluze mai puțin cosite, oferind hrană timpurie pentru albine.',
    imageAssets: ['assets/plants/viola_odorata.png'],
  ),
  'urtica_dioica': PlantInfo(
    label: 'urtica_dioica',
    nameRo: 'Urzică',
    latin: 'Urtica dioica',
    status: 'LC',
    descriptionRo:
        'Urzica mare este una dintre plantele cu cea mai lungă istorie de utilizare de către om, '
        'o perenă viguroasă din familia Urticaceae cu valențe alimentare, textile și medicinale. '
        'Tulpinile pătrunghiulare (60–150 cm) și frunzele oval-cordate sunt acoperite cu peri urticanți ce injectează '
        'acid formic, histamină și serotonină la contact, provocând o senzație de arsură. '
        'Florile mici, verzui, sunt dispuse în panicule suspendate; planta este dioică, cu sexe separate. '
        'Indică soluri bogate în azot și fosfor. Frunzele tinere sunt bogate în fier, vitamina C și proteine; '
        'se consumă fierte în supe, ciorbe și umpluturi pentru plăcinte. '
        'Extractele sunt utilizate în tratamentul artritei, al problemelor prostatei și ca tonic capilar în cosmetică.',
    imageAssets: ['assets/plants/urtica_dioica.jpg'],
  ),
};

PlantInfo? getPlantInfo(String label) => plantInfoByLabel[label];

String getStatusLabelRo(String status) => plantStatusInfo[status]?.labelRo ?? status;

Color getStatusColor(String status) => plantStatusInfo[status]?.color ?? const Color(0xFF888888);

bool isRedListStatus(String status) => status != 'LC';