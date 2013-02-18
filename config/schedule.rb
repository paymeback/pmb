every 1.Hour do
  runner "ezbupdater_controller.dollar"
  runner "ezbupdater_controller.yen"
  runner "ezbupdater_controller.rouble"
  runner "ezbupdater_controller.pund"
 
end

every 1.Minutes do
  runner "exchange.dollar"
  runner "exchange.yen"
  runner "exchange.rouble"
  runner "exchange.pund"
  command "echo 'you can use raw cron syntax one'"
 
end
