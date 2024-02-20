Private Sub Application_ItemSend(ByVal Item As Object, Cancel As Boolean)
    ' Récupère l'heure actuelle
    Dim heure As Date
    heure = Time

    ' Définit les heures de début et de fin pour le stationery "day"
    Dim heureDebut As Date
    Dim heureFin As Date
    heureDebut = TimeValue("08:00:00")
    heureFin = TimeValue("18:00:00")

    ' Vérifie si l'heure actuelle est entre les heures de début et de fin pour le stationery "day"
    If heure >= heureDebut And heure <= heureFin Then
        ' Applique le stationery "day" au message
        Item.GetInspector.ModifiedFormPages("Papeterie et polices").Controls("Stationery").Value = "Nom du stationery day"
    Else
        ' Applique le stationery "night" au message
        Item.GetInspector.ModifiedFormPages("Papeterie et polices").Controls("Stationery").Value = "Nom du stationery night"
    End If
End Sub
