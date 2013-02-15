class UsdollarController < ApplicationController
require 'rubygems'
require 'nokogiri'
require 'open-uri'  
	def index

	doc = Nokogiri::XML(File.open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'))

	@dollar = doc.xpath('//Cube[currency='USD']/rate').text

	end
  end
end
