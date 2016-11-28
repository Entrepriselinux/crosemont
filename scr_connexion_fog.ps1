#================================================================
# Projet : Script de connecxion après le poussage d'image de fog.
# Membres : Nicolas Lafranchise, Robert Bournival , Mimau
# Date :
# Professeur: Pièrre Coutu
# 
#
#===============================================================





# ================== Déclaration des fonctions du programme ==================

function Bienvenu
{
 Write-Host " 
 ========================================================================================================================
 =====                                                                                                              =====
 =====> Bienvenu dans le script de test des différentes connexions et paramètres après le poussage d'image de FOG. <=====
 =====                                                                                                              =====
 ========================================================================================================================
 "}

 function Aide_cli {
 Write-Host "

 `t`t`t`t*********************************************************************************
 `t`t`t`t*                                                                               *
 `t`t`t`t*    Ce script permet de vérifier les différentes informations suivantes :      *
 `t`t`t`t*                                                                               *
 `t`t`t`t*                                                                               *
 `t`t`t`t*          1. Les postes ont une connexion avec internet.                       *
 `t`t`t`t*          2. Les postes sont bien connectés au domaine.                        *
 `t`t`t`t*                                                                               *
 `t`t`t`t*                                                                               *
 `t`t`t`t*                                                                               *
 `t`t`t`t*********************************************************************************
 "}


 function Aide_cmd {
 Write-Host "
 La syntaxe des commandes doit être comme suit :

                          ===> scr_connexion_fog local option

               Exemple :  ===> scr_connexion_fog b338 -d
 "}

function menu {
Write-Host "
    ╔=========================================================================================================╗
	║                                                                                                         ║
	║`t`tVeuillez choisir parmit les options suivantes :                                                   ║ 
    ║                                                                                                         ║ 
	║`t`t`h ===> Affiche l'aide.                                                                            ║ 
    ║                                                                                                         ║
	║`t`t`i ===> Permet de vérifier que les postes du local résolvent Internet et www.google.com.           ║
	║                                                                                                         ║
	║`t`t`d ===> Permet de vérifier si les postes en linux et en windows sont connectés au domaine.         ║
    ╚=========================================================================================================╝
"
}

function Get_liste_ip {

$local=$args[0]
if ( $args[0] -eq "B314") 
    {
    $liste_ip = New-Object System.Collections.ArrayList
    $i=101
    while ( $i -le 131) {$liste_ip+="10.1.0.$i";$i+=1}
    }

elseif ( $args[0] -eq "B326")
    {
    $liste_ip = New-Object System.Collections.ArrayList
    $i=101
    while ( $i -le 131) {$liste_ip+="10.2.0.$i";$i+=1}
    }
elseif ( $args[0] -eq "B338") 
    {
    $liste_ip = New-Object System.Collections.ArrayList
    $i=101
    while ( $i -le 132) {$liste_ip+="10.3.0.$i";$i+=1}
    }
$liste_ip
}

function Get_liste_PC {

$local=$args[0]
if ( $args[0] -eq "B314") 
    {
    $liste_pc = New-Object System.Collections.ArrayList
    $i=1
    while ( $i -le 9) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"0$i";$i+=1}
    while ( $i -le 31) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"$i";$i+=1}
    }

elseif ( $args[0] -eq "B326")
    {
    $liste_pc = New-Object System.Collections.ArrayList
    $i=1
    while ( $i -le 9) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"0$i";$i+=1}
    while ( $i -le 31) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"$i";$i+=1}
    }
elseif ( $args[0] -eq "B338") 
    {
    $liste_pc = New-Object System.Collections.ArrayList
    $i=1
    while ( $i -le 9) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"0$i";$i+=1}
    while ( $i -le 33) {$liste_pc+="B"+$local.Substring(1,3)+"E"+"$i";$i+=1}
    }
$liste_pc
}

function Tester-Connexion {
  
  $liste_ip=$args[0]
  foreach ( $ip in $liste_ip ) {
    try {
    if (Test-Connection -Source $ip google.ca -Count 1 -ErrorAction Stop) {
       
        Write-Host -ForegroundColor green "Test internet réussi pour l'hôte : $ip"
      }
     }
     catch [Exception] {Write-Host -ForegroundColor red "Aucune connexion n'a pu être établie pour l'hôte : $ip "}
 }
}

function Tester-domaine {
$liste_pc=$args[0]
$local=$args[1]
$local=$local.ToUpper()
$root = ([adsi]'LDAP://DC=dept-info,DC=crosemont,DC=quebec','objectCategory=computer')
$searcher = new-object System.DirectoryServices.DirectorySearcher($root)
$searcher.filter = "(&(objectCategory=computer)(cn=$local*))"
$searcher.propertiesToLoad.Add("name")
$computers = $searcher.findall()
$liste_computer=$computers | Select-Object {$_.properties.name}

$i=0
while ($i -lt $liste_pc.Length) {
        $pc=$($liste_computer -match $liste_pc[$i])
        $poste=$liste_pc[$i]
        $valeur=$($pc.Count)
        if ( $valeur = 1 )
        {Write-Host -ForegroundColor green "Le poste $poste est inscrit au domaine."}
        else {Write-Host -ForegroundColor red "le poste $liste_pc[$i] n'est pas inscrit au domaine."}
    $i+=1
    }
}

function bye {
write-host "
    `t`t`t`t`t Merci d'avoir utilisé ce programme.
    `t`t`t`t`t ====================================

`t`t`t`t´´´´´´´´´´´´´´´´´´´´´¶´´´¶´´´´´´´´´¶´´´¶´´´´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´´´´¶´´¶¶´´´´´´´´´¶¶´´¶´´´´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´´´´¶¶´¶¶¶´´´´´´´¶¶¶´¶¶´´´´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´¶´´´´´´¶¶´´´¶¶¶´´´´´¶¶¶´´´¶¶´´´´´´¶´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´¶¶´´´´´´¶¶´´´¶¶¶´´´´´¶¶¶´´´¶¶´´´´´´¶¶´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´¶¶´´´´´´¶¶´´´´¶¶¶¶´´´¶¶¶¶´´´´¶¶´´´´´´¶¶´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´¶¶¶´´´´´¶¶¶´´´´¶¶¶¶¶´¶¶¶¶¶´´´´¶¶¶´´´´´¶¶¶´´´´´´´´´´
`t`t`t`t´´´´´´´¶´´¶¶¶¶´´´¶¶¶¶´´´´¶¶¶¶´´´¶¶¶¶´´´´¶¶¶¶´´´¶¶¶¶´´¶´´´´´´´
`t`t`t`t´´´´´´´¶¶´¶¶¶¶¶´´¶¶¶¶´´´¶¶¶¶¶´´´¶¶¶¶¶´´´¶¶¶¶´´¶¶¶¶¶´¶¶´´´´´´´
`t`t`t`t´´´´´´´¶¶´¶¶¶¶¶´´¶¶¶¶¶¶¶¶¶¶¶´´´´´¶¶¶¶¶¶¶¶¶¶¶´´¶¶¶¶¶´¶¶´´´´´´´
`t`t`t`t´´´´´´´¶¶´¶¶¶¶¶´´¶¶¶¶¶¶¶¶¶¶¶´´´´´¶¶¶¶¶¶¶¶¶¶¶´´¶¶¶¶¶´¶¶´´´´´´´
`t`t`t`t´´´´´´¶¶¶´´¶¶¶¶´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´¶¶¶¶´´¶¶¶´´´´´´
`t`t`t`t´´´´´¶¶¶¶´´¶¶¶¶´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´¶¶¶¶´´¶¶¶¶´´´´´
`t`t`t`t´´´´¶¶¶¶´´´¶¶¶¶¶´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´¶¶¶¶¶´´´¶¶¶¶´´´´
`t`t`t`t´´´¶¶¶¶´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´¶¶¶¶¶´´´
`t`t`t`t´´´¶¶¶¶¶´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´¶¶¶¶¶´´´
`t`t`t`t´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´
`t`t`t`t´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´
`t`t`t`t´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´
`t`t`t`t´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´
`t`t`t`t´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´
`t`t`t`t´´´´´´´¶¶¶¶¶´´´´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´´´¶¶¶¶¶´´´´´´´
`t`t`t`t´´´´´´´´¶¶¶¶¶¶´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´¶¶¶¶¶¶´´´´´´´´
`t`t`t`t´´´´´´´´´¶¶¶¶¶¶¶´´´´´´´´´´¶¶¶¶¶¶¶¶¶´´´´´´´´´´¶¶¶¶¶¶¶´´´´´´´´´
`t`t`t`t´´´´´´´´´´¶¶¶¶¶¶¶¶´´´´´´´´´¶¶¶¶¶¶¶´´´´´´´´´¶¶¶¶¶¶¶¶´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´¶¶¶¶¶´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´¶¶¶´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´¶¶¶´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶´´´´´´´¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶¶´´´´´´´¶¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶¶´¶¶¶¶¶´¶¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´¶¶¶´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´¶¶¶´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´¶¶´´¶¶¶¶´´¶¶¶¶¶´´¶¶¶¶´´¶¶´´´´´´´´´´´´´´´´´´
`t`t`t`t´´´´´´´´´´´´´´´´´´´´´´¶¶¶¶´´¶¶¶¶¶´´¶¶¶¶´´´´´´´´´´´´


"
}


# Affichage du message de Bienvenu

if ($($args.Length) -eq 0 ) { 

    Bienvenu


    [string]$choix = ""
    menu
    $choix = read-Host Entrez votre choix
    while ($choix -ne "q"){

        if ($choix -eq "h") {Aide_cli}

        if ($choix -eq "i")
        {
            $local=Read-Host "Dans quel local vous êtes ? (B314, B326 ou B338)"
            $local=$local.ToUpper()
            Tester-Connexion (Get_liste_ip $local)
        }

        if ($choix -eq "d" )
        {
            $local=Read-Host "Dans quel local vous êtes ? (B314, B326 ou B338)"
            $local=$local.ToUpper()
            Tester-domaine (Get_liste_Pc $local) $local
        }
        menu
        $choix = read-Host Entrez votre choix
    }
    bye
    }
else {

    $local=$args[0]
    $local.ToUpper()
    $option=$args[1]

    switch ($option){
     -i {Tester-Connexion (Get_liste_ip $local); break}
     -d {Tester-domaine (Get_liste_PC $local) $local; break}
     default {write-host -ForegroundColor red "Option invalide";Aide_cmd; break}
     }

}