# -*- encoding : utf-8 -*-
Sitron::Application.routes.draw do


  namespace :administracao do
    resources :empresas do 
     get "listar_cidades",on: :collection
     get "listar_bairros",on: :collection
    end
    resources :combustiveis
    resources :configuracoes do 
      post :salvar_skin,on: :collection
    end
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
