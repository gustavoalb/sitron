# -*- encoding : utf-8 -*-
#require 'resque/server' 
Sitron::Application.routes.draw do

  namespace :administracao do
    resources :escolas
  end

  namespace :gerencia do
    get 'controle_requisicoes/index'
    get 'controle_requisicoes/detalhes_requisicao'
    post 'controle_requisicoes/definir_posto'
    post 'controle_requisicoes/cancelar_requisicao'
  end

  resources :usuarios do

    get :listar_departamentos, on: :collection

  end

  namespace :administracao do
    resources :motivos
  end

  namespace :administracao do
    resources :contratos
  end

  resources :notificacoes do
    post :marcar_vista, :on=>:collection
  end

  resources :mensagens do 
   post :marcar_lida,on: :collection
  end

  match '/calendario(/:year(/:month))' => 'calendario#index', :as => :calendario, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/},:via=>:get
  #match '/requisicoes/tipo_carga/?motivo_id=:id', :controller=>'requisicoes', :action => 'tipo_carga',:via=>"post"
 #mount Resque::Server => "/internal/resque"


  resources :requisicoes do 
    get :agendar,on: :collection
    post :agendar_requisicao,on: :collection
    get :requisicao_urgente,on: :collection
    post :agendar_requisicao_urgente,on: :collection
    get :tipo_carga,:on=>:collection
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
     get 'lat_lng_cidade',on: :collection
    end
  end

  namespace :administracao do
    resources :rotas do 
      get "tipo_destino",on: :collection
      get "destino",on: :collection
    end
  end



  get 'patio/index'


  resources :patio,only: [:index] do 
    post  :ordernar_veiculo
    post  :adicionar_posto,on: :collection
    get   :entrada,on: :collection
    get   :saida,on: :collection
    post  :saida_servico,on: :collection
    post  :chegada_servico,on: :collection
    post  :saida_veiculo,on: :collection
    post  :remover_posto, on: :collection
    
  end

  namespace :administracao do
    resources :modalidades
  end

  namespace :administracao do
    resources :empresas do 
     get "listar_cidades",on: :collection
     get "listar_bairros",on: :collection
     get 'autocomplete_pessoa_nome',on: :collection
     get 'lat_lng_cidade',on: :collection
    end
    resources :combustiveis
    resources :configuracoes do 
      post :salvar_skin,on: :collection
    end

    resources :veiculos do 
      get :imprimir_codigos, on: :collection
       get "listar_lotes",on: :collection
    end
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
