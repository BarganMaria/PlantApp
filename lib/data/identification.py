"""
Script v5 - fix User-Agent pentru CloudFront (Amazon CDN al iNaturalist).
"""

import os
import time
import json
import urllib.request
import urllib.parse

OUTPUT_DIR = "assets/plants"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# User-Agent de browser real — CloudFront blocheaza bot-urile
BROWSER_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "image/webp,image/apng,image/*,*/*;q=0.8",
}

API_HEADERS = {
    "User-Agent": "PlantCatalogMD/1.0",
    "Accept": "application/json",
}

PLANTS = {
    "aconitum_lasiostomum":       "Aconitum lasiostomum",
    "anemone_sylvestris":         "Anemone sylvestris",
    "campanula_sibirica":         "Campanula sibirica",
    "centaurea_cyanus":           "Centaurea cyanus",
    "chrysanthemum_x_morifolium": "Chrysanthemum morifolium",
    "colchicum_autumnale":        "Colchicum autumnale",
    "convallaria_majalis":        "Convallaria majalis",
    "dianthus_carthusianorum":    "Dianthus carthusianorum",
    "fritillaria_ruthenica":      "Fritillaria ruthenica",
    "galanthus_nivalis":          "Galanthus nivalis",
    "glechoma_hederacea":         "Glechoma hederacea",
    "helianthus_annuus":          "Helianthus annuus",
    "hyssopus_officinalis":       "Hyssopus officinalis",
    "iris_pumila":                "Iris pumila",
    "iris_sibirica":              "Iris sibirica",
    "iris_variegata":             "Iris variegata",
    "lamium_album":               "Lamium album",
    "lavandula_angustifolia":     "Lavandula angustifolia",
    "leucanthemum_vulgare":       "Leucanthemum vulgare",
    "lilium_martagon":            "Lilium martagon",
    "matricaria_chamomilla":      "Matricaria chamomilla",
    "mentha_piperita":            "Mentha piperita",
    "muscari_neglectum":          "Muscari neglectum",
    "narcissus_pseudonarcissus":  "Narcissus pseudonarcissus",
    "nuphar_lutea":               "Nuphar lutea",
    "nymphaea_alba":              "Nymphaea alba",
    "paeonia_tenuifolia":         "Paeonia tenuifolia",
    "papaver_rhoeas":             "Papaver rhoeas",
    "petunia_x_hybrida":          "Petunia hybrida",
    "plantago_lanceolata":        "Plantago lanceolata",
    "platanthera_bifolia":        "Platanthera bifolia",
    "rosa_x_hybrida":             "Rosa canina",
    "scilla_siberica":            "Scilla siberica",
    "silybum_marianum":           "Silybum marianum",
    "tulipa_biebersteiniana":     "Tulipa biebersteiniana",
    "tulipa_gesneriana":          "Tulipa gesneriana",
    "typha_latifolia":            "Typha latifolia",
    "urtica_dioica":              "Urtica dioica",
}


def get_photo_url(latin_name):
    params = urllib.parse.urlencode({
        "q": latin_name,
        "rank": "species",
        "per_page": 1,
    })
    url = f"https://api.inaturalist.org/v1/taxa?{params}"
    try:
        req = urllib.request.Request(url, headers=API_HEADERS)
        with urllib.request.urlopen(req, timeout=15) as resp:
            data = json.loads(resp.read().decode())
        results = data.get("results", [])
        if not results:
            return None
        photo = results[0].get("default_photo")
        if photo:
            return photo.get("medium_url") or photo.get("square_url")
    except Exception as e:
        print(f"    Eroare API: {e}")
    return None


def download_image(url, dest_path):
    for attempt in range(3):
        try:
            req = urllib.request.Request(url, headers=BROWSER_HEADERS)
            with urllib.request.urlopen(req, timeout=20) as resp:
                data = resp.read()
            if len(data) < 2000:
                print(f"    Fisier prea mic.")
                return False
            with open(dest_path, "wb") as f:
                f.write(data)
            print(f"    OK: {len(data)//1024} KB -> {dest_path}")
            return True
        except Exception as e:
            wait = 2 ** attempt
            print(f"    Eroare (incercare {attempt+1}): {e} — astept {wait}s")
            time.sleep(wait)
    return False


def main():
    print(f"Descarcam {len(PLANTS)} specii de pe iNaturalist...\n")
    ok = fail = skip = 0

    for label, latin in PLANTS.items():
        dest = os.path.join(OUTPUT_DIR, f"{label}.jpg")
        dest_png = os.path.join(OUTPUT_DIR, f"{label}.png")

        if (os.path.exists(dest) or os.path.exists(dest_png)) and \
           max(
               os.path.getsize(dest) if os.path.exists(dest) else 0,
               os.path.getsize(dest_png) if os.path.exists(dest_png) else 0
           ) > 2000:
            print(f"[SKIP] {latin}")
            skip += 1
            continue

        print(f"[->]  {latin}")
        url = get_photo_url(latin)

        if not url:
            print(f"    Nu s-a gasit.")
            fail += 1
            time.sleep(1)
            continue

        success = download_image(url, dest)
        ok += 1 if success else 0
        fail += 0 if success else 1
        time.sleep(0.5)

    print(f"\nRezultat: {ok} descarcate, {fail} erori, {skip} sarite")


if __name__ == "__main__":
    main()