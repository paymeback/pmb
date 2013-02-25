module DebtsHelper
	$cyclecounter = 0
	$cyclemax = 3 #(1 = 3er Ketten, 2 = 4er Ketten ...)

	def self.killoldandcreatenew
		dellist
		createlist
	end

	def self.dellist
		x = Debtniceview.count
		y=0
		while y < x
			todel = Debtniceview.first
			todel.destroy
			y += 1
		end
	end

	def self.dellist2
		x = Debtcycle.count
		y=0
		while y < x
			todel = Debtcycle.first
			todel.destroy
			y += 1
		end
	end

	# in killdoubles werden alle Einträge, bei denen Schuldner 
	# und Gläubiger gleich sind aussortiert
	def self.killdoublesandcross
		dellist
		killthem
		killthecross
	end

	# in killthem werden  AA -> BB Beziehungen gekillt
	def self.killthem
		# zunächst werden die Daten der aktuellen Debtniceview in Arrays gepackt
		data = Debt.select("value, debitor_id, creditor_id")
		valuearray = data.select('value').map{|elem|elem.value}
		debitorarray = data.select('debitor_id').map{|elem|elem.debitor_id}
		creditorarray = data.select('creditor_id').map{|elem|elem.creditor_id}

		# nun werden Einträge, bei denen Schuldner und Gläubiger gleich sind gesucht
		# die Schulden werden zusammengerechnet
		x = valuearray.size
		z = 0
		y = 1
		while z < x-1
			while y < x
				# Abfrage, ob Person A Person B mehrfach etwas schuldet
				if debitorarray[z] == debitorarray[y] && creditorarray[z] == creditorarray[y]
					valuearray[z] += valuearray[y]
					valuearray[y] = 0
				end
				y += 1
			end
			z += 1
			y = z + 1
		end

		# Hier werden alle Werte in die Zwischentabelle geschrieben, 
		#	bei denen value != 0 ist
		a = valuearray.size
		b=0
		while b < a
			if valuearray[b] != 0
				debtniceview = Debtniceview.new
				debtniceview.value = valuearray[b]
				debtniceview.debitor_id = debitorarray[b]
				debtniceview.creditor_id = creditorarray[b]
				debtniceview.save
			end
			b += 1
		end
	end

	# in killthecross werden  AB -> BA Beziehungen gekillt
	def self.killthecross
		# zunächst werden die Daten der aktuellen Debtniceview in Arrays gepackt
		data = Debtniceview.select("value, debitor_id, creditor_id")
		valuearray = data.select('value').map{|elem|elem.value}
		debitorarray = data.select('debitor_id').map{|elem|elem.debitor_id}
		creditorarray = data.select('creditor_id').map{|elem|elem.creditor_id}

		# nun wird die bisherige Liste gelöscht
		dellist
		
		# nun werden Einträge, bei denen Schuldner und Gläubiger gleich sind gesucht
		# die Schulden werden zusammengerechnet
		x = valuearray.size
		z = 0
		y = 1
		while z < x-1
			while y < x
				# Abfrage, ob Person A Person B und Person B Person A etwas schuldet
				if debitorarray[z] == creditorarray[y] && creditorarray[z] == debitorarray[y]
					if valuearray[z] > valuearray[y]
						valuearray[z] -= valuearray[y]
						valuearray[y] = 0
					else
						valuearray[y] -= valuearray[z]
						valuearray[z] = 0
					end
				end
				y += 1
			end
			z += 1
			y = z + 1
		end
		# Hier werden alle Werte in die Zwischentabelle geschrieben, 
		#	bei denen value != 0 ist
		a = valuearray.size
		b=0
		while b < a
			if valuearray[b] != 0
				debtniceview = Debtniceview.new
				debtniceview.value = valuearray[b]
				debtniceview.debitor_id = debitorarray[b]
				debtniceview.creditor_id = creditorarray[b]
				debtniceview.save
			end
			b += 1
		end
	end

	# Ab hier startet die Kreisverrechnung
	def self.circle
		data = Debtniceview.select("value, debitor_id, creditor_id")
		$valuearray = data.select('value').map{|elem|elem.value}
		$debitorarray = data.select('debitor_id').map{|elem|elem.debitor_id}
		$creditorarray = data.select('creditor_id').map{|elem|elem.creditor_id}

		w = 0
		while w < $valuearray.size
			# Start debitor und creditor werden eingestellt
			if $valuearray[w] != 0
				debitor = $debitorarray[w]
				creditor = $creditorarray[w]
				x = 0
				while x < $valuearray.size
					# Die Gleichheit von Startcreditor und [x] Debitor wird verglichen
					if creditor == $debitorarray[x]
						#STEP BY STEP !!!!!
						xyzarray = [w,x]
						$cyclecounter=0
						cyclestep(debitor, xyzarray)
					end
					x += 1
				end
				w += 1
			end
		end
	# Nach dem Durchlauf kann aus den Arrays wieder in eine Tabelle geschrieben werden
		dellist2 # vorab löschen
		a = $valuearray.size
		b=0
		while b < a
			if $valuearray[b] != 0
				debtcycle = Debtcycle.new
				debtcycle.value = $valuearray[b]
				debtcycle.debitor_id = $debitorarray[b]
				debtcycle.creditor_id = $creditorarray[b]
				debtcycle.save
			end
			b += 1
		end
	end

# Prüfung, ob in einer Situation ein Kreis vorliegt
	def self.cyclestep(debitor, xyzarray)
		debitor2 = $creditorarray[xyzarray[xyzarray.size-1]]
		y = 0
		while y < $valuearray.size
			xyzarray += [y]
			# Bei true wird nun jeder Schuldner/Gläubiger gesuchtt
			if debitor2 == $debitorarray[y]
				# Falls dieser auch Schulden/Guthaben beim Startdebitorhat
				# liegt ein Dreieck vor
				if debitor == $creditorarray[y]
					# Dreieck gefunden: 
					# Der niedrigste Schuldenstand wird allen abgezogen				
					#cyclevaluewriter(xyzarray)
					cyclevaluewriter(xyzarray)
				else
					# Kein Dreieck, aber vllt ein Viereck!
					$cyclecounter += 1
					if $cyclecounter < $cyclemax
						cyclestep(debitor, xyzarray)
					# Selbstaufruf!
					end	
					$cyclecounter -= 1
				end
			end
			xyzarray.delete_at(xyzarray.size-1)
			y += 1				
		end
	end

	def self.cyclevaluewriter(xyzarray)
		# Zunächst wird der kleinste Wert ermittelt
		v = 1
		minvalue = $valuearray[xyzarray[0]]		
		while v < xyzarray.size
			if $valuearray[xyzarray[v]] < minvalue
				minvalue = $valuearray[xyzarray[v]]		
			end	
			v += 1
		end
		# Nun wird der kleinste Wert abgezogen
		# Hierbei muss es sich um den ersten Wert handeln!
		# Jede mögliche Schulden-Kombination wird durchgegangen.
		# Für eine Kette darf aber nur einmal ein Betrag abgezogen werden
		if minvalue == $valuearray[xyzarray[0]]
			u = 0
			while u < xyzarray.size
				$valuearray[xyzarray[u]] -= minvalue
				u += 1
			end
		end
	end
end
