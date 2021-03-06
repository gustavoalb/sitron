# -*- encoding : utf-8 -*-
class Administracao::DepartamentosController < ApplicationController
   before_action :set_administracao_departamento, only: [:show, :edit, :update, :destroy]
   before_action :load_departamento, only: :create
   load_and_authorize_resource :class => "Administracao::Departamento", except: :create

   # GET /administracao/departamentos
   # GET /administracao/departamentos.json
   autocomplete :pessoa, :nome, :class_name => "Administracao::Pessoa"

   def index
      @administracao_departamentos = Administracao::Departamento.accessible_by(current_ability).order(:nome)
   end

   # GET /administracao/departamentos/1
   # GET /administracao/departamentos/1.json
   def show
   end

   # GET /administracao/departamentos/new
   def new
      @administracao_departamento = Administracao::Departamento.new
      @endereco = @administracao_departamento.build_endereco
   end

   # GET /administracao/departamentos/1/edit
   def edit
      @endereco = @administracao_departamento.endereco
      @estado = @endereco.estado
      if @endereco.cidade_id
         @cidade = @estado.cidades.find(@endereco.cidade_id)
      else
         @cidade = @estado.cidades.first
      end
      @cidades = @estado.cidades.collect { |c| [c.nome, c.id] }
      @bairros = @cidade.bairros.collect { |b| [b.nome, b.id] }
   end

   # POST /administracao/departamentos
   # POST /administracao/departamentos.json
   def create
      @administracao_departamento = Administracao::Departamento.new(administracao_departamento_params)

      respond_to do |format|
         if @administracao_departamento.save
            format.html { redirect_to @administracao_departamento, notice: 'Departamento foi criado com sucesso.' }
            format.json { render :show, status: :created, location: @administracao_departamento }
         else
            @endereco = @administracao_empresa.build_endereco
            format.html { render :new }
            format.json { render json: @administracao_departamento.errors, status: :unprocessable_entity }
         end
      end
   end


   def listar_cidades
      @estado = Estado.find(params[:estado_id])
      @cidades = @estado.cidades.all
      #render :partial=>"cidades",:locals=>{:endereco=>@endereco,:cidades=>@cidades}

      response = []
      @cidades.each do |cidade|
         response << {:id => cidade.id, :n => cidade.nome}
      end
      render :json => {:response => response.compact}.as_json
   end


   def listar_bairros
      @cidade = Cidade.find(params[:cidade_id])
      @bairros = @cidade.bairros.all.collect { |b| [b.nome, b.id] }

      render :partial => "bairros", :locals => {:bairros => @bairros}
   end

   # PATCH/PUT /administracao/departamentos/1
   # PATCH/PUT /administracao/departamentos/1.json
   def update
      respond_to do |format|
         if @administracao_departamento.update(administracao_departamento_params)
            format.html { redirect_to @administracao_departamento, notice: 'Departamento foi atualizado com sucesso.' }
            format.json { render :show, status: :ok, location: @administracao_departamento }
         else
            @endereco = @administracao_departamento.endereco
            format.html { render :edit }
            format.json { render json: @administracao_departamento.errors, status: :unprocessable_entity }
         end
      end
   end

   # DELETE /administracao/departamentos/1
   # DELETE /administracao/departamentos/1.json
   def destroy
      @administracao_departamento.destroy
      respond_to do |format|
         format.html { redirect_to administracao_departamentos_url, notice: 'Departamento foi removido do sistema.' }
         format.json { head :no_content }
      end
   end


   def lat_lng_cidade
      @cidade = Cidade.find(params[:cidade_id])

      # render :partial=>"mapa",:locals=>{:destino=>@destino}

      response = []

      response << {:latitude => @cidade.latitude, :longitude => @cidade.longitude}
      render :json => {:response => response.compact}.as_json

   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_administracao_departamento
      @administracao_departamento = Administracao::Departamento.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def administracao_departamento_params
      params.require(:administracao_departamento).permit(:nome, :sigla, :nome_responsavel, :descricao, :entidade_id, :responsavel_id, :e_um_destino, :usa_moto,:usa_especial,endereco_attributes: [:logradouro, :numero, :complemento, :estado_id, :cidade_id, :bairro_id, :cep, :endereco, :latitude, :longitude])
   end

   def load_departamento
      @administracao_departamento = Administracao::Departamento.new(administracao_departamento_params)
   end
end
