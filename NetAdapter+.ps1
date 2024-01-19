# NetAdapterPlus_v1.0.0


# ----------------------------------------------------------------------------------------------- #

# Vérifier si l'exécution se fait avec des droits administrateurs
$adminRights = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Si l'exécution ne se fait pas avec des droits administrateurs, redémarrer en tant qu'administrateur
if (-not $adminRights) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}


# ----------------------------------------------------------------------------------------------- #

# NAMESPACE
$netAdapters = Get-NetAdapter -Physical
$selectedOption = 0


# ----------------------------------------------------------------------------------------------- #

# Fonction d'affichage du menu
function Show-Menu {
    param (
        [int]$selected
    )
    # Le principe est de simuler un menu interactif
    Clear-Host
    Write-Host "NetAdapterPlus_v1.0.0 [Janvier, 2024]`n" -ForegroundColor DarkCyan
    Write-Host
    Write-Host " ╔═════════════════════════════════════╦══════════════════╦═════════════════════════════════════╗"
    Write-Host " ║                                     ║   NetAdapter +   ║                                     ║"
    Write-Host " ╠═════════════════════════════════════╩══════════════════╩═════════════════════════════════════╣"
    Write-Host " ║                                                                                              ║"
    Write-Host " ║ ┌────────────────┬────────────────────────────────────────────┬───────────────┬────────────┐ ║"
    Write-Host " ║ │ Name           │ InterfaceDescription                       │ Status        │   LinkSpeed│ ║"
    Write-Host " ║ ├────────────────┼────────────────────────────────────────────┼───────────────┼────────────┤ ║"

    # Boucle bornée qui itère les différentes cartes réseau pour les afficher en fonction de la sélection
    for ($i = 0; $i -lt $netAdapters.Count; $i++) {

        # Définition de variables pour simplifier le programme
        if ($netAdapters[$i].Status -eq "Disabled") {$color = "red"} else {$color = "green"}
        # Si erreur à l'affichage, augmenter le nombre et modifier le menu en conséquence
        $remplissage1 = 13 - ($netAdapters[$i].Name).Length
        $remplissage2 = 42 - ($netAdapters[$i].InterfaceDescription).Length
        $remplissage3 = 13 - ($netAdapters[$i].Status).Length
        $remplissage4 = 11 - ($netAdapters[$i].LinkSpeed).Length
        
        # Affichage pour les cartes réseau (sauf la dernière)
        if ($i -lt ($netAdapters.Count - 1)) {
            if ($i -eq $selected) { # Affichage si selectionné
                Write-Host " ║ │► " -NoNewline
                # ----------------
                Write-Host $netAdapters[$i].Name -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage1) "│ " -NoNewline
                Write-Host $netAdapters[$i].InterfaceDescription -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage2) "│ " -NoNewline
                Write-Host $netAdapters[$i].Status -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage3) "│" (" " * $remplissage4) -NoNewline
                Write-Host $netAdapters[$i].LinkSpeed -ForegroundColor $color -NoNewline
                Write-Host "│ ║"
                # ----------------
                Write-Host " ║ ├────────────────┼────────────────────────────────────────────┼───────────────┼────────────┤ ║"
            }
            else { # Affichage si non selectionné
                Write-Host " ║ │  " -NoNewline
                # ----------------
                Write-Host $netAdapters[$i].Name -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage1) "│ " -NoNewline
                Write-Host $netAdapters[$i].InterfaceDescription -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage2) "│ " -NoNewline
                Write-Host $netAdapters[$i].Status -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage3) "│" (" " * $remplissage4) -NoNewline
                Write-Host $netAdapters[$i].LinkSpeed -ForegroundColor $color -NoNewline
                Write-Host "│ ║"
                # ----------------
                Write-Host " ║ ├────────────────┼────────────────────────────────────────────┼───────────────┼────────────┤ ║"
            }
        }
        # Affichage pour la dernière carte réseau
        else {
            if ($i -eq $selected) { # Affichage si selectionné
                Write-Host " ║ │► " -NoNewline
                # ----------------
                Write-Host $netAdapters[$i].Name -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage1) "│ " -NoNewline
                Write-Host $netAdapters[$i].InterfaceDescription -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage2) "│ " -NoNewline
                Write-Host $netAdapters[$i].Status -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage3) "│" (" " * $remplissage4) -NoNewline
                Write-Host $netAdapters[$i].LinkSpeed -ForegroundColor $color -NoNewline
                Write-Host "│ ║"
                # ----------------
                Write-Host " ║ ╘════════════════╧════════════════════════════════════════════╧═══════════════╧════════════╛ ║"
            }
            else { # Affichage si non selectionné
                Write-Host " ║ │  " -NoNewline
                # ----------------
                Write-Host $netAdapters[$i].Name -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage1) "│ " -NoNewline
                Write-Host $netAdapters[$i].InterfaceDescription -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage2) "│ " -NoNewline
                Write-Host $netAdapters[$i].Status -ForegroundColor $color -NoNewline
                Write-Host (" " * $remplissage3) "│" (" " * $remplissage4) -NoNewline
                Write-Host $netAdapters[$i].LinkSpeed -ForegroundColor $color -NoNewline
                Write-Host "│ ║"
                # ----------------
                Write-Host " ║ ╘════════════════╧════════════════════════════════════════════╧═══════════════╧════════════╛ ║"
            }
        }
    }
    Write-Host " ║                                                                                              ║"
    Write-Host " ╟──────────────────────────────────────────────────────────────────────────────────────────────╢"
    Write-Host " ║ Entrée : Valider                                                           ↑↓ : Sélectionner ║"
    Write-Host " ║  Échap : Quitter                                                                             ║"
    Write-Host " ╚══════════════════════════════════════════════════════════════════════════════════════════════╝`n"
}


# ----------------------------------------------------------------------------------------------- #

# Début Programme
Show-Menu -selected $selectedOption

# Boucle infinie permettant l'interaction continue
while ($true) {
    $keyInfo = [System.Console]::ReadKey($true)
    
    # Différentes touches qui génèrent une action :
    switch ($keyInfo.Key) {

        # "Echap" pour quitter le script
        "Escape" {
            Exit
        }
        # "Flèche du haut" pour monter dans le menu
        "UpArrow" {
            if ($selectedOption -ne [Math]::Max(0, $selectedOption - 1)) {
                $selectedOption -= 1
                $netAdapters = Get-NetAdapter -Physical
                Show-Menu -selected $selectedOption
            }
        }
        # "Flèche du bas" pour descendre dans le menu
        "DownArrow" {
            if ($selectedOption -ne [Math]::Min($netAdapters.Count - 1, $selectedOption + 1)) {
                $selectedOption += 1
                $netAdapters = Get-NetAdapter -Physical
                Show-Menu -selected $selectedOption
            }
        }
        # "Entrée" pour sélectionner une option du menu
        "Enter" {
            if (($netAdapters[$selectedOption]).Status -eq "Disabled") {
                Write-Host " Activation de la carte" $netAdapters[$selectedOption].Name"..." -ForegroundColor Cyan
                Enable-NetAdapter -Name $netAdapters[$selectedOption].Name
                $netAdapters = Get-NetAdapter -Physical
                Show-Menu -selected $selectedOption
            }
            else {
                Write-Host " Désactivation de la carte" $netAdapters[$selectedOption].Name"..." -ForegroundColor Cyan
                Disable-NetAdapter -Name $netAdapters[$selectedOption].Name -Confirm:$false
                $netAdapters = Get-NetAdapter -Physical
                Show-Menu -selected $selectedOption
            }
        }
        # Valeur par défaut
        Default {}
    }
}