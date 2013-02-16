class UsdollarController < ApplicationController
attr_accessor :dollar

require 'rubygems'
require 'nokogiri'
require 'open-uri'  
before_filter :index	
	
	def index
		doc = Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"))
		dollar = doc.xpath("//ecb:Cube[@currency='USD']/@rate", 'ecb' => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref")
	return dollar
	end

	
end		
