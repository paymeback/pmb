class UsdollarController < ApplicationController
require 'rubygems'
require 'nokogiri'
require 'open-uri'  
	def index

	doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
	@dollar = doc.xpath("//ecb:Cube[@currency='USD']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref" )
	
	end
end		
