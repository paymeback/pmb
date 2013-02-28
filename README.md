PayMeBack - PMB by DebtNinjas
===
Mit dem Service "PayMeBack" ist es möglich Schulden, die man z.B. zwischen Freunden, Arbeitskollegen etc. hat, übersichtlich zu erfassen.

PayMeBack - In Detail
---
Schulden haben eine Debitor und Kreditor.Nur eingeloggte Benutzer (zu finden in den seeds) können jedeglich die Schuldenübersicht sehen und nutzen. Eine Schuld kann __optional__ ein Fälligkeitsdatum, dieses darf nicht in der Vergangenheit liegen, oder ein Beleg als Anhang besitzen.Mögliche Anhänge sind PDF's,JPG's oder PNG's. 

Es gilt folgendes _"Warnsystem"_ für die Schulden:
- Grün, wenn die Schuld beglichen wurde
- Gelb, wenn kein Fälligkeitsdatum vorhanden oder die Schuld noch nicht beglichen ist
- Orange, wenn die Schuld in 7 Tagen beglichen werden muss
- Rot, wenn das Fälligkeitsdatum vor dem aktuellen Datum liegt

Weiterhin ist es mögich, sich die Schuld in anderen Währungen als Euro anzeigen zu lassen. Hierzu zählen folgende Währungen: __Dollar, Yen, Pfund, Rubel und Bitcoin__.

Zudem werden Kreise und Kreuzverbindungen unter den Benutzern des Service aufgelöst.Sodass es sein kann, dass durch einen aufgelösten Kreis ein Benutzer keine Schuld mehr hat.

To get it up and running
---
- Clone the respository
- Run: `bundle install --without production`
- Run: `db:setup`

That's all ;).

###Gem Notes
Aufgrund von Problem auf 64 Bit Systemen und Installationsproblemen mit älteren Versionen des Gem's libv8 für twitter-bootstrap, wird dieses ab der Version >=3.11.8.7 und das Gem rubyracer ab Version >=0.11.3 verwendet. 

Tests
---
Es existieren insgesamt _6_ Tests. Aufgrund der Speicherung in der Dropbox ist es nicht möglich den Test "create debt with valid file" ein zweites Mal auszuführen. Er führt in dem Sinne zum gewünschten Ergbnis beim zweiten Mal, da er fehlschlägt aufgrund, dass die Datei bereits vorhanden ist. Dies ist dem Umstand geschuldet, dass ein einzigartiger Dateiname gewählt wird, der sich aus dem Namen des Models, der Id der Schuld und dem internen Namen des Anhangs zusammensetzt.

###Folgende Tests werden angewendet:
- 3 Tests zum Erstellen von Schulden mit und ohne Anhängen. Dabei werden valide und nicht valide Dateien getestet. Diese befinden sich im Ordner "spec/fixtures".
- 1 Integrationstest zur Überprüfung ob eine beglichene Schuld vom Kreditor gelöscht werden kann
- 1 Helpers- Test zur Überprüfung ob die Auflösung von Kreisen und Kreuzverindungen funktioniert
- 1 Test zur Überprüfung der Umrechnung einer Schuld in andere Währungen
