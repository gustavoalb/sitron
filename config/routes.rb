# -*- encoding : utf-8 -*-
#require 'resque/server' 
Sitron::Application.routes.draw do
    
  mount Blorgh::Engine, at: "/blog"

  namespace :administracao do
    resources :relatorios_diarios
  end

  namespace :administracao do
    resources :banco_de_horas
  end


  

  namespace :administracao do
    resources :escolas
  end

  namespace :gerencia do
    get 'controle_requisicoes/index'
    get 'controle_requisicoes/detalhes_requisicao'
    post 'controle_requisicoes/definir_posto'
    post 'controle_requisicoes/definir_veiculo_final_semana'
    post 'controle_requisicoes/cancelar_requisicao'
    post 'controle_requisicoes/cancelar_confirmada'
    get 'controle_requisicoes/especial'
    post 'controle_requisicoes/salvar_requisicao'
    get  'controle_requisicoes/gerenciar_requisicoes'
    post  'controle_requisicoes/ordernar_requisicao'
    post 'controle_requisicoes/chegada_servico'
    post 'controle_requisicoes/saida_servico'
     post 'controle_requisicoes/cancelar_posto'
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
   get :ler
  end

  match '/calendario(/:year(/:month))' => 'calendario#index', :as => :calendario, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/},:via=>:get
  #match '/requisicoes/tipo_carga/?motivo_id=:id', :controller=>'requisicoes', :action => 'tipo_carga',:via=>"post"
 #mount Resque::Server => "/internal/resque"


  resources :requisicoes, except: [:edit] do 
    get :agendar,on: :collection
    get :final_semana,on: :collection
    post :agendar_requisicao,on: :collection
    get :requisicao_urgente,on: :collection
    get :teste,on: :collection
    post :agendar_requisicao_urgente,on: :collection
    get :tipo_carga,:on=>:collection
    get :imprimir_requisicao
    post :avaliar
    post :salvar_pessoa,on: :collection
    get :relatorio_horas,on: :collection
    get :relatorio_requisicoes_periodo, on: :collection
    get :relatorio_detalhado,on: :collection
    get :imprimir_relatorio_detalhado,on: :collection
    get :imprimir_relatorio, on: :collection
    get :exportar_excel,on: :collection
    get 'lat_lng_cidade',on: :collection
    get :listar_rota
    get :relatorio_excel, on: :collection

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
    resources :rotas,except: [:edit] do 
      get "tipo_destino",on: :collection
      get "destino",on: :collection
    end
  end



  get 'patio/index'
  get "home/nao_autorizado"
  get "home/busca"
  get "home/manual"


  resources :patio,only: [:index] do 
    post  :ordernar_veiculo
    post  :adicionar_posto,on: :collection
    get   :entrada,on: :collection
    get   :saida,on: :collection
    get   :controle_manual,on: :collection
    get   :relatorio_presencial,on: :collection
    get   :imprimir_relatorio,on: :collection
    post  :saida_servico,on: :collection
    post  :chegada_servico,on: :collection
    post  :saida_veiculo,on: :collection
    post  :remover_posto, on: :collection
    post :chat,on: :collection
    post :sair_patio,on: :collection
    
  end

  namespace :api do
    namespace :v1  do
      resources :tokens,:only => [:create, :destroy]
    end
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
       post :remover_posto
    end
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations",sessions: "sessions"}
  resources :users
end
