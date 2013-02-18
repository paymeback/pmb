module DebtsHelper
	def killoldandcreatenew
		dellist
		createlist
	end

	def dellist
		x = Debtniceview.count
		y=0
		while y < x
			todel = Debtniceview.first
			todel.destroy
			y += 1
		end
	end

	def dellist2
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
	def killdoublesandcross
		dellist
		killthem
		killthecross
	end

	# in killthem werden  AA -> BB Beziehungen gekillt
	def killthem
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
	def killthecross
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

	# Ab hier startet die Dreieckverrechnung und Viereckverrechnung
	def circle
		data = Debtniceview.select("value, debitor_id, creditor_id")
		valuearray = data.select('value').map{|elem|elem.value}
		debitorarray = data.select('debitor_id').map{|elem|elem.debitor_id}
		creditorarray = data.select('creditor_id').map{|elem|elem.creditor_id}

		w = 0
		while w < valuearray.size
			# Start debitor und creditor werden eingestellt
			if valuearray[w] != 0
				debitor = debitorarray[w]
				creditor = creditorarray[w]
				x = 0
				while x < valuearray.size
					# Die Gleichheit von Startcreditor und [x] Debitor wird verglichen
					if creditor == debitorarray[x]
						debitor2 = creditorarray[x]
						y = 0
						while y < valuearray.size
						# Bei true wird nun jeder Schuldner/Gläubiger gesuchtt
							if debitor2 == debitorarray[y]
							# Falls dieser auch Schulden/Guthaben beim Startdebitorhat
							# liegt ein Dreieck vor
								if debitor == creditorarray[y]
									# Dreieck gefunden: 
									# debitor schuldet creditor
									#	creditor schuldet debitor2
									#	debitor2 schuldet debitor
									# Der niedrigste Schuldenstand wird allen abgezogen
									if valuearray[w] < valuearray[x] && valuearray[w] < valuearray[y]
										valuearray[x] -= valuearray[w]
										valuearray[y] -= valuearray[w]
										valuearray[w] = 0
									end	

								# Kein Dreieck, aber vllt ein Viereck!						
								else
									debitor3 = creditorarray[y]
									z = 0
									while z < valuearray.size
										if debitor3 == debitorarray[z]
											# Falls dieser auch Schulden/Guthaben beim Startdebitorhat
											# liegt ein Viereck vor
											if debitor == creditorarray[z]
												# Viereck gefunden: 
												# debitor schuldet creditor
												#	creditor schuldet debitor2
												#	debitor2 schuldet debitor3
												#	debitor3 schuldet debitor
												# Der niedrigste Schuldenstand wird allen abgezogen
												if valuearray[w] < valuearray[x] && valuearray[w] < valuearray[y] && valuearray[w] < valuearray[z]
													valuearray[x] -= valuearray[w]
													valuearray[y] -= valuearray[w]
													valuearray[z] -= valuearray[w]
													valuearray[w] = 0
												end

											# Kein Viereck, aber vllt ein Fünfeck
											else
												debitor4 = creditorarray[z]
												a = 0
												while a < valuearray.size
													if debitor4 == debitorarray[a]
														# Falls dieser auch Schulden/Guthaben beim Startdebitorhat
														# liegt ein Fünfeck vor
														if debitor == creditorarray[a]
															# Viereck gefunden: 
															# debitor schuldet creditor
															#	creditor schuldet debitor2
															#	debitor2 schuldet debitor3
															#	debitor3 schuldet debitor4
															#	debitor4 schuldet debitor
															# Der niedrigste Schuldenstand wird allen abgezogen
															if valuearray[w] < valuearray[x] && valuearray[w] < valuearray[y] && valuearray[w] < valuearray[z] && valuearray[w] < valuearray[a]
																valuearray[x] -= valuearray[w]
																valuearray[y] -= valuearray[w]
																valuearray[z] -= valuearray[w]
																valuearray[a] -= valuearray[w]
																valuearray[w] = 0
															end
														end
													end
													a += 1
												end
											end
											# Fünfeckende
										end										
										z += 1
									end
									# Viereckende
								end
							end
							y += 1				
						end
						# Dreieckende
					end
					x += 1
				end
				w += 1
			end
		end
	# Nach dem Durchlauf kann aus den Arrays wieder in eine Tabelle geschrieben werden
		dellist2 # vorab löschen
		a = valuearray.size
		b=0
		while b < a
			if valuearray[b] != 0
				debtcycle = Debtcycle.new
				debtcycle.value = valuearray[b]
				debtcycle.debitor_id = debitorarray[b]
				debtcycle.creditor_id = creditorarray[b]
				debtcycle.save
			end
			b += 1
		end
	end
end
