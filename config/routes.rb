Rails.application.routes.draw do

  get 'cities/show'
  root 'gossips#index'
  get '/team', to: 'statics#team'
  get '/contact', to: 'statics#contact'
  get '/welcome/:name', to: 'statics#welcome', as: 'welcome'
  resources :gossips
  resources :authors, only: [:show]
  resources :cities, only: [:show]

end

