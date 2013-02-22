Paymeback::Application.routes.draw do


  ActiveAdmin.routes(self)
  
  get "ezbupdater" => "ezbupdater#rouble"
  get "ezbupdater/rouble" => "ezbupdater#rouble"
  devise_for :users

  resources :debts, :usergroups, :usdollar

  root :to => "debts#index"
end
