Paymeback::Application.routes.draw do


  get "debts/mydebts"

  ActiveAdmin.routes(self)
  
  get "debts" => "debts#mydebts"
  get "debts/mydebts" => "debts#mydebts"
  devise_for :users

  resources :debts, :usergroups, :usdollar

  root :to => "debts#index"
end
