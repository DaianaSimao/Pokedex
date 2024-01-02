Rails.application.routes.draw do
  resources :pokedex
  root 'pokedex#index'
end
