require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.start_new
scheduler.every("10s") do
  Exchange.dollar
  Exchange.yen
  Exchange.rouble
  Exchange.pund
 
end

