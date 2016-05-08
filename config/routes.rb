Rails.application.routes.draw do

  get "/" => "items#index", as: :home
  resources :items
end
