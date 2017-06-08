
Rails.application.routes.draw do

  resources :subbers
  resources :stats
  resources :register
  root to: "main#index"

end
