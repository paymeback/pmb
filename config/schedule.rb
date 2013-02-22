require 'rubygems'
require 'active_support/core_ext/numeric/time'


every 1.minutes do
  runner "Exchange.dollar"
  runner "Exchange.yen"
  runner "Exchange.rouble"
  runner "Exchange.pund"
 
end
