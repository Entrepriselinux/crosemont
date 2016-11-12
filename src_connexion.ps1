# Charger Winforms assembly
Add-Type –AssemblyName System.Windows.Forms 

# Créer la fenêtre principale
$MainForm = New-Object System.Windows.Forms.Form
$MainForm.Text = "Test de connexion"
$MainForm.StartPosition = "CenterScreen"
$MainForm.Width = 500
$MainForm.Height = 500
# Enlever les bouton Maximiser et Minimiser
#$MainForm.MaximizeBox = $False
#$MainForm.MinimizeBox = $False


# Menu à bouton radiaux
# Création d'un groupbox
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(20,20)
$groupBox.size = New-Object System.Drawing.Size(100,100)
$groupBox.text = "Locaux:"
$MainForm.Controls.Add($groupBox)
# Créer Les boutons radiaux
$RadioButton1 = New-Object System.Windows.Forms.RadioButton 
$RadioButton1.Location = new-object System.Drawing.Point(15,15) 
$RadioButton1.size = New-Object System.Drawing.Size(80,20) 
$RadioButton1.Checked = $true 
$RadioButton1.Text = "B-314" 
$groupBox.Controls.Add($RadioButton1) 

$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton2.Location = new-object System.Drawing.Point(15,45)
$RadioButton2.size = New-Object System.Drawing.Size(80,20)
$RadioButton2.Text = "B-326"
$groupBox.Controls.Add($RadioButton2)

$RadioButton3 = New-Object System.Windows.Forms.RadioButton
$RadioButton3.Location = new-object System.Drawing.Point(15,75)
$RadioButton3.size = New-Object System.Drawing.Size(80,20)
$RadioButton3.Text = "B-338"
$groupBox.Controls.Add($RadioButton3)


# Création des boutons
# Bouton Test
$ButtonTest = New-Object System.Windows.Forms.Button
$ButtonTest.Text = "Tester"
$ButtonTest.Location = ‘60,400’
# Bouton Quit
$ButtonQuit = New-Object System.Windows.Forms.Button
$ButtonQuit.Text = "Quitter"
$ButtonQuit.Location = ‘140,400’

# Ajouter les bouton à la fenêtre principale
$MainForm.Controls.Add($ButtonTest)
$MainForm.Controls.Add($ButtonQuit)

# Évènement relié au bouton Tester
$ButtonTest.add_Click({
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

})

# Évènement relié au bouton Quitter
$ButtonQuit.Add_Click({
    $MainForm.Close()
})


# Affichage de la fenêtre
$MainForm.ShowDialog()


