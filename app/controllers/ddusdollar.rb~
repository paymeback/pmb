require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::XML(File.open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'))

@dollar = doc.xpath('//Cube[currency='USD']/rate').each do |e|

end
