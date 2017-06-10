
Rails.application.routes.draw do

  resources :subbers
  get '*unmatched_route', :to => "main#index"
  root to: "main#index"

end
