param(
    [int]$Tirages = 1,
    [switch]$SansAnimation
)

$lots = @(
    [pscustomobject]@{ Rang = 1;  Nom = "Dodo";              Niveau = 45;  Poids = 120; Classe = "Dodo_Character_BP_C" },
    [pscustomobject]@{ Rang = 2;  Nom = "Lystrosaurus";      Niveau = 50;  Poids = 110; Classe = "Lystro_Character_BP_C" },
    [pscustomobject]@{ Rang = 3;  Nom = "Phiomia";           Niveau = 55;  Poids = 100; Classe = "Phiomia_Character_BP_C" },
    [pscustomobject]@{ Rang = 4;  Nom = "Parasaur";          Niveau = 60;  Poids = 95;  Classe = "Para_Character_BP_C" },
    [pscustomobject]@{ Rang = 5;  Nom = "Dilophosaure";      Niveau = 65;  Poids = 90;  Classe = "Dilo_Character_BP_C" },
    [pscustomobject]@{ Rang = 6;  Nom = "Carbonemys";        Niveau = 70;  Poids = 84;  Classe = "Turtle_Character_BP_C" },
    [pscustomobject]@{ Rang = 7;  Nom = "Iguanodon";         Niveau = 75;  Poids = 78;  Classe = "Iguanodon_Character_BP_C" },
    [pscustomobject]@{ Rang = 8;  Nom = "Raptor";            Niveau = 80;  Poids = 72;  Classe = "Raptor_Character_BP_C" },
    [pscustomobject]@{ Rang = 9;  Nom = "Triceratops";       Niveau = 85;  Poids = 66;  Classe = "Trike_Character_BP_C" },
    [pscustomobject]@{ Rang = 10; Nom = "Pteranodon";        Niveau = 90;  Poids = 60;  Classe = "Ptero_Character_BP_C" },
    [pscustomobject]@{ Rang = 11; Nom = "Ankylosaurus";      Niveau = 95;  Poids = 54;  Classe = "Ankylo_Character_BP_C" },
    [pscustomobject]@{ Rang = 12; Nom = "Doedicurus";        Niveau = 100; Poids = 49;  Classe = "Doed_Character_BP_C" },
    [pscustomobject]@{ Rang = 13; Nom = "Stegosaurus";       Niveau = 105; Poids = 44;  Classe = "Stego_Character_BP_C" },
    [pscustomobject]@{ Rang = 14; Nom = "Direwolf";          Niveau = 110; Poids = 39;  Classe = "Direwolf_Character_BP_C" },
    [pscustomobject]@{ Rang = 15; Nom = "Argentavis";        Niveau = 115; Poids = 34;  Classe = "Argent_Character_BP_C" },
    [pscustomobject]@{ Rang = 16; Nom = "Baryonyx";          Niveau = 120; Poids = 30;  Classe = "Baryonyx_Character_BP_C" },
    [pscustomobject]@{ Rang = 17; Nom = "Thylacoleo";        Niveau = 125; Poids = 26;  Classe = "Thylacoleo_Character_BP_C" },
    [pscustomobject]@{ Rang = 18; Nom = "Megatherium";       Niveau = 130; Poids = 22;  Classe = "Megatherium_Character_BP_C" },
    [pscustomobject]@{ Rang = 19; Nom = "Mammouth";          Niveau = 135; Poids = 19;  Classe = "Mammoth_Character_BP_C" },
    [pscustomobject]@{ Rang = 20; Nom = "Rex";               Niveau = 140; Poids = 16;  Classe = "Rex_Character_BP_C" },
    [pscustomobject]@{ Rang = 21; Nom = "Spino";             Niveau = 145; Poids = 13;  Classe = "Spino_Character_BP_C" },
    [pscustomobject]@{ Rang = 22; Nom = "Yutyrannus";        Niveau = 150; Poids = 11;  Classe = "Yuty_Character_BP_C" },
    [pscustomobject]@{ Rang = 23; Nom = "Basilosaurus";      Niveau = 155; Poids = 9;   Classe = "Basilosaurus_Character_BP_C" },
    [pscustomobject]@{ Rang = 24; Nom = "Giganotosaurus";    Niveau = 160; Poids = 7;   Classe = "Gigant_Character_BP_C" },
    [pscustomobject]@{ Rang = 25; Nom = "Carcharodontosaurus"; Niveau = 165; Poids = 6; Classe = "Carcha_Character_BP_C" },
    [pscustomobject]@{ Rang = 26; Nom = "Quetzal";           Niveau = 170; Poids = 5;   Classe = "Quetz_Character_BP_C" },
    [pscustomobject]@{ Rang = 27; Nom = "Tusoteuthis";       Niveau = 175; Poids = 4;   Classe = "Tusoteuthis_Character_BP_C" },
    [pscustomobject]@{ Rang = 28; Nom = "Mosasaurus";        Niveau = 180; Poids = 3;   Classe = "Mosa_Character_BP_C" },
    [pscustomobject]@{ Rang = 29; Nom = "Rhyniognatha";      Niveau = 185; Poids = 2;   Classe = "Rhynio_Character_BP_C" },
    [pscustomobject]@{ Rang = 30; Nom = "Titanosaur";        Niveau = 190; Poids = 1;   Classe = "Titanosaur_Character_BP_C" }
)

function Get-Lot {
    param([object[]]$ListeLots)

    $total = ($ListeLots | Measure-Object -Property Poids -Sum).Sum
    $tirage = Get-Random -Minimum 1 -Maximum ($total + 1)
    $cumul = 0

    foreach ($lot in $ListeLots) {
        $cumul += $lot.Poids
        if ($tirage -le $cumul) {
            return $lot
        }
    }
}

function Get-Prestige {
    param([int]$Rang)

    if ($Rang -le 10) { return "Commun" }
    if ($Rang -le 18) { return "Rare" }
    if ($Rang -le 24) { return "Epique" }
    if ($Rang -le 28) { return "Legendaire" }
    return "Mythique"
}

function Show-Animation {
    param([object[]]$ListeLots)

    for ($i = 0; $i -lt 18; $i++) {
        $lot = $ListeLots | Get-Random
        Write-Host ("`rLa roue tourne... {0,-24}" -f $lot.Nom) -NoNewline
        Start-Sleep -Milliseconds (40 + ($i * 12))
    }
    Write-Host ""
}

Write-Host ""
Write-Host "=== Roue des dinos - ARK Ascended ===" -ForegroundColor Cyan
Write-Host "Lots: 30 dinos classes du moins prestigieux au plus prestigieux."
Write-Host "Astuce: modifie Niveau, Poids ou Classe directement dans ce fichier."
Write-Host ""

for ($i = 1; $i -le $Tirages; $i++) {
    if (-not $SansAnimation) {
        Show-Animation -ListeLots $lots
    }

    $gagnant = Get-Lot -ListeLots $lots
    $prestige = Get-Prestige -Rang $gagnant.Rang
    $commande = 'admincheat GMSummon "{0}" {1}' -f $gagnant.Classe, $gagnant.Niveau

    Write-Host ("Tirage #{0}" -f $i) -ForegroundColor DarkGray
    Write-Host ("Lot gagne : #{0}/30 - {1}" -f $gagnant.Rang, $gagnant.Nom) -ForegroundColor Green
    Write-Host ("Prestige  : {0}" -f $prestige)
    Write-Host ("Niveau    : {0}" -f $gagnant.Niveau)
    Write-Host ("Commande  : {0}" -f $commande) -ForegroundColor Yellow
    Write-Host ""
}
