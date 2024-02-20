Option Explicit

Dim objOutlook, objNameSpace, objFolder, objItems, objMail
Dim strStationery, strTime, strHour

'Création d'une instance Outlook
Set objOutlook = CreateObject("Outlook.Application")
Set objNameSpace = objOutlook.GetNamespace("MAPI")

'Obtention du dossier Boîte de réception
Set objFolder = objNameSpace.GetDefaultFolder(6)

'Obtention des éléments de la boîte de réception
Set objItems = objFolder.Items

'Obtention de l'heure système
strTime = Time
strHour = Hour(strTime)

'Si l'heure est entre 18H et 8H, définit la papeterie de nuit, sinon définit la papeterie de jour
If strHour >= 18 Or strHour < 8 Then
	strStationery = "C:\Chemin\vers\night.htm" 'chemin vers le fichier HTML de la papeterie de nuit
Else
	strStationery = "C:\Chemin\vers\day.htm" 'chemin vers le fichier HTML de la papeterie de jour
End If

'Création d'un nouvel e-mail avec la papeterie définie
Set objMail = objOutlook.CreateItem(0)
objMail.BodyFormat = olFormatHTML
objMail.HTMLBody = "<html><body><p>Ceci est un message de test</p></body></html>" 'message de test
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle = olNotTheme
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.UseTheme = False
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeFont.Size = 12
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeFont.Name = "Arial"
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle.Font = "No Spacing"
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle.ParagraphFormat.SpaceBeforeAuto = False
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle.ParagraphFormat.SpaceBefore = 0
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle.ParagraphFormat.SpaceAfterAuto = False
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStyle.ParagraphFormat.SpaceAfter = 0
objMail.GetInspector().WordEditor.Application.ActiveDocument.EmailOptions.ComposeStationery = strStationery
objMail.Display

'Libération des objets
Set objMail = Nothing
Set objItems = Nothing
Set objFolder = Nothing
Set objNameSpace = Nothing
Set objOutlook = Nothing
