#------------------------------------------------------------------------------#
# Programme:        src_connexion.ps1                                          #
# Description:               #
#                                                                              #
# Auteurs:          Robert Bournival, Nicolas Lafranchise                      #
# Date:             Dimanche 22-11-2016                                        #
# Version PS:       5.1.14393.206                                              #
#------------------------------------------------------------------------------#
<#
SYNOPSIS
Describe the function here
DESCRIPTION
Describe the function in more detail
EXAMPLE
Give an example of how to use it
EXAMPLE
Give another example of how to use it
PARAMETER computername
The computer name to query. Just one.
PARAMETER logname
The name of a file to write failed computer names to. Defaults to errors.txt.
#>
#-------------------------------- Importations --------------------------------#
# Ajouter le type Windows Forms
Add-Type –AssemblyName System.Windows.Forms 

#--------------------------------- Fonctions ----------------------------------#
function Tester-Connexion {
  <#
  .SYNOPSIS
  Describe the function here
  .DESCRIPTION
  Describe the function in more detail
  .EXAMPLE
  Give an example of how to use it
  .EXAMPLE
  Give another example of how to use it
  .PARAMETER computername
  The computer name to query. Just one.
  .PARAMETER logname
  The name of a file to write failed computer names to. Defaults to errors.txt.
  #>
  param (
      $source
  )
  return $(Test-Connection -Count 1 -Source $source 8.8.8.8)
}

Function Save-File {
  <#
  .SYNOPSIS
  Describe the function here
  .DESCRIPTION
  Describe the function in more detail
  .EXAMPLE
  Give an example of how to use it
  .EXAMPLE
  Give another example of how to use it
  .PARAMETER computername
  The computer name to query. Just one.
  .PARAMETER logname
  The name of a file to write failed computer names to. Defaults to errors.txt.
  #>
  [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
  $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
  $SaveFileDialog.Filter = "Text files (*.txt)|*.txt"
  $SaveFileDialog.InitialDirectory = $(Get-Location)
  [void]$SaveFileDialog.ShowDialog()
    #if ($SaveFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK)
    #{ $SaveFileDialog.FileName }
}
#--------------------------------- Variables ----------------------------------#
#[array]


if ($args.Count -eq 0)
    {Write-Host Graphique}
elseif ($args.Count -ne 0)
    {Write-Host Shell}

# Créer les objets
$MainForm = New-Object System.Windows.Forms.Form
$GroupBox = New-Object System.Windows.Forms.GroupBox
$RadioButton1 = New-Object System.Windows.Forms.RadioButton 
$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton3 = New-Object System.Windows.Forms.RadioButton
$ButtonTest = New-Object System.Windows.Forms.Button
$ButtonSave = New-Object System.Windows.Forms.Button
$ButtonQuit = New-Object System.Windows.Forms.Button
$OutputBox = New-Object System.Windows.Forms.TextBox 

# Ajouter le texte aux objets
$MainForm.Text = "Test de connexion"
$GroupBox.Text = "Locaux:"
$RadioButton1.Text = "B-314" 
$RadioButton2.Text = "B-326"
$RadioButton3.Text = "B-338"
$ButtonTest.Text = "Tester"
$ButtonSave.Text = "Enregistrer"
$ButtonQuit.Text = "Quitter"
$OutputBox.Text = ""

# Positionnement des objets
$MainForm.StartPosition = "CenterScreen"
$GroupBox.Location = New-Object System.Drawing.Size(40,20)
$RadioButton1.Location = New-Object System.Drawing.Point(15,15) 
$RadioButton2.Location = New-Object System.Drawing.Point(15,45)
$RadioButton3.Location = New-Object System.Drawing.Point(15,75)
$ButtonTest.Location = "180,100"
$ButtonSave.Location = "280,100"
$ButtonQuit.Location = "380,100"
$OutputBox.Location = New-Object System.Drawing.Size(10,150) 

# Dimenssionnement des objets
$MainForm.Size = New-Object System.Drawing.Size(600,400)
$MainForm.Width = 600
$MainForm.Height = 400
$GroupBox.size = New-Object System.Drawing.Size(100,100)
$RadioButton1.size = New-Object System.Drawing.Size(80,20) 
$RadioButton2.size = New-Object System.Drawing.Size(80,20)
$RadioButton3.size = New-Object System.Drawing.Size(80,20)
#$ButtonTest.Location = "180,100"
$ButtonSave.size = "76,23"
#$ButtonQuit.Location = "380,100"
$OutputBox.Size = New-Object System.Drawing.Size(565,200) 

# Paramètres additionnels des objets
#$MainForm.MaximizeBox = $False
#$MainForm.MinimizeBox = $False
$OutputBox.MultiLine = $true
$OutputBox.ScrollBars = "Vertical"
#$OutputBox.MaxLength = "0"
$OutputBox.ReadOnly = $true
$OutputBox.BackColor = "White"
$Radiobutton1.Checked = $false
$Radiobutton2.Checked = $false
$Radiobutton3.Checked = $false



# Ajouter les objets
$GroupBox.Controls.Add($RadioButton1) 
$GroupBox.Controls.Add($RadioButton2)
$GroupBox.Controls.Add($RadioButton3)
$MainForm.Controls.Add($GroupBox)
$MainForm.Controls.Add($ButtonTest)
$MainForm.Controls.Add($ButtonSave)
$MainForm.Controls.Add($ButtonQuit)
$MainForm.Controls.Add($OutputBox) 


# Évènements reliés au objets
$ButtonQuit.Add_Click({$MainForm.Close()})
# Évènement relié au bouton Tester
$ButtonTest.Add_Click({
    $result=$(Tester-Connexion localhost)
    $OutputBox.text=$Result
})
$ButtonSave.Add_Click({
    $filename = Save-File
    $OutputBox.Text | out-file $filename
})

<#if ($RadioButton1.Checked -eq $true) {$nrOfPings=1}
if ($RadioButton2.Checked -eq $true) {$nrOfPings=2}
if ($RadioButton3.Checked -eq $true) {$nrOfPings=3}

$computer=$DropDownBox.SelectedItem.ToString() #populate the var with the value you selected
$pingResult=ping $wks -n $nrOfPings | fl | out-string;
$outputBox.text=$pingResult


# Création d'une fenêtre de résultats
$Popup=New-Object System.Windows.Forms.Form
$Popup.Size = ‘120,120’ 
$Popup.Text = "Résultat des tests"
$Popup.StartPosition = "CenterScreen"
$Popup.Visible = $true
$Label = New-Object System.Windows.Forms.Label
$Label.Text = "Hello World!"
$Label.AutoSize = $true
$Label.Location = ‘15,30’
$Label.Font = ‘Arial,12’

$Popup.Controls.Add($label)
#>


# Affichage de la fenêtre
[void]$MainForm.ShowDialog()

