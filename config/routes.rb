# -*- encoding : utf-8 -*-
#require 'resque/server' 
Sitron::Application.routes.draw do

 #mount Resque::Server => "/internal/resque"


  resources :requisicoes do 
    get :agendar,on: :collection
    post :agendar_requisicao,on: :collection
  end

  namespace :administracao do
    resources :cargos
  end

  namespace :administracao do
    resources :pessoas do 
     get :listar_departamentos, on: :collection
    end
  end

  namespace :administracao do
    resources :departamentos do
     get "listar_cidades",on: :collection
     get "listar_bairros",on: :collection
     get 'autocomplete_pessoa_nome',on: :collection
    end
  end

  namespace :administracao do
    resources :rotas do 
      get "tipo_destino",on: :collection
    end
  end



  get 'patio/index'

  resources :patio do 
    post :ordernar_veiculo
    post :adicionar_posto,on: :collection
  end

  namespace :administracao do
    resources :modalidades
  end

  namespace :administracao do
    resources :empresas do 
     get "listar_cidades",on: :collection
     get "listar_bairros",on: :collection
     get 'autocomplete_pessoa_nome',on: :collection
    end
    resources :combustiveis
    resources :configuracoes do 
      post :salvar_skin,on: :collection
    end

    resources :veiculos
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
