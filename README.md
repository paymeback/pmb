PayMeBack - PMB by DebtNinjas
===
Mit dem Service "PayMeBack" ist es möglich Schulden, die man z.B. zwischen Freunden, Arbeitskollegen etc. hat, übersichtlich zu erfassen.

PayMeBack - In Detail
---
Schulden haben eine Debitor und Kreditor. Eine Schuld kann _optional_ ein Fälligkeitsdatum, dieses darf nicht in der Vergangenheit liegen, oder ein Beleg als Anhang besitzen.Mögliche Anhänge sind PDF's,JPG's oder PNG's. 

Weiterhin ist es mögich, sich die Schuld in anderen Währungen als Euro anzeigen zu lassen. Hierzu zählen folgende Währungen: Dollar, Yen, Pfund, Rubel und Bitcoin.

Zudem werden Kreise und Kreuzverbindungen unter den Benutzern des Service aufgelöst.Sodass es sein kann, dass durch einen aufgelösten Kreis ein Benutzer keine Schuld mehr hat.

To get it up and running
---
- Clone the respository
- Run: `bundle install --without production`
- Run: `db:setup`

That's all ;).

Tests
---
Es existieren insgesamt 7 Tests. Aufgrund der Speicherung in der Dropbox ist es nicht möglich den Test "create debt with valid file" ein zweites Mal auszuführen. Er führt in dem Sinne zum gewünschten Ergbnis beim zweiten Mal, da er fehlschlägt aufgrund, dass die Datei bereits vorhanden ist. Dies ist dem Umstand geschuldet, dass ein einzigartiger Dateiname gewählt wird, der sich aus dem Namen des Models, der Id der Schuld und dem internen Namen des Anhangs zusammensetzt.

##Folgende Tests werden angewendet:
- 3 Tests zum Erstellen von Schulden mit und ohne Anhängen. Dabei werden valide und nicht valide Dateien getestet. Diese befinden sich im Ordner "spec/fixtures".
- 1 Integrationstest zur Überprüfung ob eine beglichene Schuld vom Kreditor gelöscht werden kann
- 1 Helpers- Test zur Überprüfung ob die Auflösung von Kreisen und Kreuzverindungen funktioniert
- 1 Test zur Überprüfung der Umrechnung einer Schuld in andere Währungen
