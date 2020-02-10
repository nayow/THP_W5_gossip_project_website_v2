Rails.application.routes.draw do

  root 'main#home'
  get '/team', to: 'main#team'
  get '/contact', to: 'main#contact'
  get '/welcome/:name', to: 'main#welcome', as: 'welcome'
  get '/home', to: 'main#home'
  get '/gossip/:gossip_id', to: 'main#gossip', as: 'gossip'
  get '/author/:author_id', to: 'main#author', as: 'author'

end
