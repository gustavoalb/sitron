class RequisicoesController < ApplicationController
  before_action :set_requisicao, only: [:show, :edit, :update, :destroy]
  before_action :load_requisicao, only: :create
  load_and_authorize_resource :class=>"Requisicao", except: :create

  # GET /requisicoes
  # GET /requisicoes.json
  add_breadcrumb "Requisições de Transporte"
  def index
    @requisicoes = Requisicao.accessible_by(current_ability)
  end

  # GET /requisicoes/1
  # GET /requisicoes/1.json
  def show
  end

  def imprimir_requisicao
    @requisicao = Requisicao.find(params[:requisicao_id])
    @posto = @requisicao.posto
    @veiculo = @posto.veiculo

    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'relatorios', 'comprovante_requisicao.tlf')
    report.start_new_page

    report.list.add_row do |row|
       row.values numero_contrato: @veiculo.contrato.numero
       row.values nome_empresa: @veiculo.empresa.nome
       row.values periodo_vigencia: @veiculo.contrato.vigencia
       row.values setor_nome: @requisicao.requisitante.departamento.nome
       row.values data_atual: Time.now.to_s_br
       row.values local_atual: @requisicao.requisitante.departamento.endereco.cidade.nome
       row.values roteiro_cumprido: @requisicao.rotas_requisicao
       row.values servidores_nome: @requisicao.servidores_nome
       row.values roteiro_cumprido_2: @requisicao.rotas_requisicao
       row.values servidores_nome_2: @requisicao.servidores_nome
       row.values numero_de_servidores: @requisicao.pessoas.count
       row.values codigo: @posto.veiculo.codigo_de_barras.file.file

    end

     send_data report.generate, filename: 'requisicao.pdf', 
     type: 'application/pdf', 
     disposition: 'attachment'
  end

  # GET /requisicoes/new
  def new
    @requisicao = Requisicao.new
    @pessoas = Administracao::Pessoa.all
  end


  def agendar
    @requisicao = Requisicao.new
    @pessoas = Administracao::Pessoa.all
  end

  def requisicao_urgente
    @requisicao = Requisicao.new
    @pessoas = Administracao::Pessoa.all
  end


  # GET /requisicoes/1/edit
  def edit
  end

  # POST /requisicoes
  # POST /requisicoes.json
  def agendar_requisicao

    @requisicao = Requisicao.new(requisicao_params)
    @requisicao.data_ida = @requisicao.inicio.to_date #if params[requisicao_params[:inicio]]
    @requisicao.hora_ida = @requisicao.inicio.to_time #if params[requisicao_params[:inicio]]
    @requisicao.periodo_longo = true
    
    respond_to do |format|
      if @requisicao.save!
        @requisicao.agendar
        format.html { redirect_to @requisicao, notice: 'A Requisição foi agendada com sucesso.' }
        format.json { render :show, status: :created, location: @requisicao }
      else
        @pessoas = Administracao::Pessoa.all
        format.html { render :agendar }
        format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @requisicao = Requisicao.new(requisicao_params)
    date_and_time = '%m-%d-%Y %H:%M:%S %Z'
    data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]}")
    data_retorno = Time.zone.parse("#{requisicao_params[:data_volta].gsub('/','-')} #{requisicao_params[:hora_volta]}")
    #data = DateTime.strptime("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]} Brasilia",date_and_time)
    @requisicao.inicio = data
    @requisicao.fim = data_retorno
    @requisicao.requisitante_id = current_user.pessoa.id
    @tipo = @requisicao.tipo_requisicao



    respond_to do |format|
      if @requisicao.save
        format.html { redirect_to @requisicao, notice: 'A Requisicao foi Criada com Sucesso' }
        format.json { render :show, status: :created, location: @requisicao }
      else
        @pessoas = Administracao::Pessoa.all
        if @tipo=="normal"
          format.html { render :new }
        elsif @tipo=="agendada"
          format.html { render :agendar }
        elsif @tipo=="urgente"
         format.html { render :requisicao_urgente }
       end
       format.json { render json: @requisicao.errors, status: :unprocessable_entity }
     end
   end
 end

  # PATCH/PUT /requisicoes/1
  # PATCH/PUT /requisicoes/1.json
  def update
    respond_to do |format|
      if @requisicao.update(requisicao_params)
        format.html { redirect_to @requisicao, notice: 'Requisicao atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @requisicao }
      else
        format.html { render :edit }
        format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisicoes/1
  # DELETE /requisicoes/1.json
  def destroy
    @requisicao.destroy
    respond_to do |format|
      format.html { redirect_to requisicoes_url, notice: 'Requisicao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tipo_carga
    if params[:motivo_id] and !params[:motivo_id].blank?
      @motivo = Administracao::Motivo.find(params[:motivo_id])
    end
    if @motivo and @motivo.carga?
      render :partial=>"partial_carga"
    elsif !@motivo or !@motivo.carga? or params[:motivo_id].blank?
      render :nothing=>true
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_requisicao
    @requisicao = Requisicao.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def requisicao_params
    params.require(:requisicao).permit(:numero, :descricao, :numero_passageiros,:requisitante_id, :data_ida, :hora_ida, :periodo,:tipo_requisicao, :periodo_longo, :inicio, :fim, :posto_id, :preferencia_id,:data_volta,:hora_volta,:motivo_id,:tipo_carga,:rota_ids=>[],:pessoa_ids=>[])
  end

  def load_requisicao
    @requisicao = Requisicao.new(requisicao_params)
  end

end
