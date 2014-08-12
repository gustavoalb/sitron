# -*- encoding : utf-8 -*-
class Administracao::VeiculosController < ApplicationController
  before_action :set_administracao_veiculo, only: [:show, :edit, :update, :destroy]
  before_action :load_veiculo, only: :create
  before_action :carregar_lotes
  load_and_authorize_resource :class=>"Administracao::Veiculo", except: :create


  # GET /administracao/veiculos
  # GET /administracao/veiculos.json
  def index
    @administracao_veiculos = Administracao::Veiculo.accessible_by(current_ability).order(:lote_id,:position)
  end

  # GET /administracao/veiculos/1
  # GET /administracao/veiculos/1.json
  def show
  end

  # GET /administracao/veiculos/new
  def new
    @administracao_veiculo = Administracao::Veiculo.new
  end

  # GET /administracao/veiculos/1/edit
  def edit
  end

  def listar_lotes
    m = Administracao::Modalidade.find(params[:modalidade_id])
    @lotes = m.lotes.order('nome ASC')

    response = []
    @lotes.each do |lote|
      response << {:id => lote.id, :n => "#{lote.nome} - #{lote.tipo}"}
    end
    render :json => {:response => response.compact}.as_json
  end

  def imprimir_codigos
    i = 1
    n = 1
    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'relatorios', 'codigos.tlf')
    report.start_new_page
 #  report.page.values printed_at: Time.zone.now
 @veiculos = Administracao::Veiculo.all
 Administracao::Lote.all.each do |l|
   l.veiculos.order(:position).each do  |v|
    m = v.modalidade
    report.list.add_row do |row|
     row.values empresa: "#{v.empresa.nome.upcase}"
     row.values codigo_barras: v.codigo_de_barras.file.file
     row.values codigo: "#{m.periodo_diario}H#{m.dias_mes}d#{v.lote.tipo}".upcase
     row.values contrato: "#{v.contrato.numero}"
     row.values vigencia: v.contrato.vigencia
     row.values qrcodes:  v.qrcode.file.file
     row.values n: v.position
   end
 end

end

send_data report.generate, filename: 'codigos.pdf', 
type: 'application/pdf', 
disposition: 'attachment'

end

  # POST /administracao/veiculos
  # POST /administracao/veiculos.json
  def create
    @administracao_veiculo = Administracao::Veiculo.new(administracao_veiculo_params)

    respond_to do |format|
      if @administracao_veiculo.save
        format.html { redirect_to @administracao_veiculo, notice: 'Veiculo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_veiculo }
      else
        format.html { render :new }
        format.json { render json: @administracao_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/veiculos/1
  # PATCH/PUT /administracao/veiculos/1.json
  def update
    respond_to do |format|
      if @administracao_veiculo.update(administracao_veiculo_params)
        format.html { redirect_to @administracao_veiculo, notice: 'Veiculo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_veiculo }
      else
        format.html { render :edit }
        format.json { render json: @administracao_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/veiculos/1
  # DELETE /administracao/veiculos/1.json
  def destroy
    @administracao_veiculo.destroy
    respond_to do |format|
      format.html { redirect_to administracao_veiculos_url, notice: 'Veiculo foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def carregar_lotes
      @lotes_veiculos = Administracao::Lote.all.order('nome ASC').collect{|l|["#{l.nome} - #{l.tipo}",l.id]}
    end
    
    def set_administracao_veiculo
      @administracao_veiculo = Administracao::Veiculo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_veiculo_params
      params.require(:administracao_veiculo).permit(:especial,:placa,:tipo_id, :motor, :direcao, :marca, :modelo, :capacidade_carga, :capacidade_passageiros, :ano_fabricacao, :ano_modelo, :intens_obrigatorios, :observacao, :modalidade_id, :combustivel_id, :turno_id,:empresa_id,:qrcode,:contrato_id,:lote_id)
    end

    def load_veiculo
      @administracao_veiculo = Administracao::Veiculo.new(administracao_veiculo_params)
    end
  end
