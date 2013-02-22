Paymeback::Application.routes.draw do
  get "usdollar/index"

  ActiveAdmin.routes(self)
  
  get "ezbupdater" => "ezbupdater#rouble"
  get "ezbupdater/rouble" => "ezbupdater#rouble"
  devise_for :users

  resources :debts, :usergroups, :usdollar

  root :to => "debts#index"
end
