class EzbupdaterController < ApplicationController
require 'rubygems'
require 'nokogiri'
require 'open-uri'  


	def dollar
		doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
		 
		exchange = Exchange.first
		exchange.value = doc.xpath("//ecb:Cube[@currency='USD']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref").text.to_f

		exchange.save
	end

	def yen
		doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
		 
		exchange = Exchange.find(2)
		exchange.value = doc.xpath("//ecb:Cube[@currency='JPY']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref").text.to_f

		exchange.save
	end

	def pund
		doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
		 
		exchange = Exchange.find(3)
		exchange.value = doc.xpath("//ecb:Cube[@currency='GBP']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref").text.to_f

		exchange.save
	end


	def rouble
		doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
		 
		exchange = Exchange.find(4)
		exchange.value = doc.xpath("//ecb:Cube[@currency='RUB']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref").text.to_f

		exchange.save
	end




end
