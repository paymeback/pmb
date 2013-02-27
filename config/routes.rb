Paymeback::Application.routes.draw do


  get "debts/mydebts"

  ActiveAdmin.routes(self)
  

  devise_for :users

  resources :debts, :usergroups, :usdollar

  root :to => "debts#index"
end
