require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.start_new
scheduler.every("6000s") do
  Exchange.dollar
  Exchange.yen
  Exchange.rouble
  Exchange.pund
  Exchange.bitcoin
 
end

