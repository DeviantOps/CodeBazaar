Sub ImportCSV()

    Dim filePath As String

    Dim fileName As String

    Dim sheetName As String

   

    ' Spécifiez le chemin d'accès au dossier contenant les fichiers CSV

    filePath = "C:\Temp\"

   

    ' Boucle sur chaque fichier CSV dans le dossier

    fileName = Dir(filePath & "*.csv")

    Do While fileName <> ""

       

        ' Récupère le nom de l'onglet à partir du nom de fichier CSV

        sheetName = Replace(fileName, ".csv", "")

       

        ' Importe le fichier CSV dans un nouvel onglet et renomme l'onglet

        With ActiveWorkbook.Sheets.Add(After:=ActiveWorkbook.Sheets(ActiveWorkbook.Sheets.Count))

            .Name = sheetName

            With .QueryTables.Add(Connection:="TEXT;" & filePath & fileName, _

                Destination:=.Range("A1"))

                .TextFileParseType = xlDelimited

                .TextFileCommaDelimiter = True

                .Refresh

            End With

        End With

       

        ' Passe au fichier CSV suivant

        fileName = Dir()

    Loop

End Sub
