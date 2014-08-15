# -*- encoding : utf-8 -*-
class RequisicoesController < ApplicationController
   before_action :set_requisicao, only: [:show, :edit, :update, :destroy]
   before_action :load_requisicao, only: :create
   before_action :load_pessoa, only: :salvar_pessoa
   before_action :load_pessoas
   load_and_authorize_resource :class => "Requisicao", except: :create

   # GET /requisicoes
   # GET /requisicoes.json
   add_breadcrumb "Requisições de Transporte"

   def index
      @requisicoes = Requisicao.aguardando.accessible_by(current_ability)
      @requisicoes_confirmadas = Requisicao.confirmada.accessible_by(current_ability)
      @requisicoes_canceladas = Requisicao.canceladas.accessible_by(current_ability)
      @requisicoes_finalizadas = Requisicao.finalizadas.accessible_by(current_ability)
   end

   # GET /requisicoes/1
   # GET /requisicoes/1.json
   def show
      @ary = []
      @ultima = nil
      gon.caminhos = []
      if params[:notificacao]
         @notificacao = current_user.notificacoes_recebidas.find(params[:notificacao])
         @notificacao.ver unless @notificacao.vista?
      end

      if !@requisicao.endereco.nil?
         gon.latitude = @requisicao.endereco.latitude
         gon.longitude = @requisicao.endereco.longitude
      elsif @requisicao.rotas.count > 0
         @ultima = @requisicao.rotas.last

         gon.latitude = @requisicao.rotas.last.latitude
         gon.longitude = @requisicao.rotas.last.longitude

         @requisicao.rotas.each do |r|
            gon.caminhos.push [r.latitude, r.longitude] unless r.id == @ultima.id
         end

      end


   end


   def imprimir_requisicao
      @requisicao = Requisicao.find(params[:requisicao_id])
      @posto = @requisicao.posto
      @veiculo = @posto.veiculo
      @m = @veiculo.modalidade

      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'relatorios', 'comprovante_requisicao.tlf')
      report.start_new_page

      report.list.add_row do |row|

         row.values numero_contrato: @veiculo.contrato.numero
         row.values nome_empresa: @veiculo.empresa.nome
         row.values periodo_vigencia: @veiculo.contrato.vigencia
         row.values setor_nome: @requisicao.requisitante.departamento.nome
         row.values setor_nome_2: @requisicao.requisitante.departamento.nome
         row.values data_atual: Time.now.to_s_br
         row.values local_atual: @requisicao.requisitante.departamento.endereco.cidade.nome
         row.values roteiro_cumprido: @requisicao.rotas_requisicao
         row.values servidores_nome: @requisicao.servidores_nome
         row.values roteiro_cumprido_2: @requisicao.rotas_requisicao
         row.values nome_solicitante: @requisicao.requisitante.nome
         row.values numero_de_servidores: @requisicao.pessoas.count
         row.values codigo: @requisicao.codigo_de_barras.placa.file.file
         if @requisicao.qrcode.present?
            row.values qrcode: @requisicao.qrcode.file.file
         end
         row.values codigo_texto: @requisicao.codigo
         row.values autorizacao_transporte: @requisicao.numero
         row.values data_saida: @requisicao.data_ida.to_s_br
         row.values periodo_saida: @requisicao.periodo_da_requisicao
         row.values hora_saida_2: @requisicao.inicio.in_time_zone("Brasilia").strftime("%H:%M")
         row.values observacoes: @requisicao.descricao
         row.values hora_chegada_2: @requisicao.fim.in_time_zone("Brasilia").strftime("%H:%M")
         row.values servico_executado: @requisicao.servico_executado
         row.values deslocamento: @requisicao.tipo_requisicao.camelcase
         row.values veiculo: PatioController.helpers.info_posto_print(@posto)
         if @requisicao.numero_da_portaria
            row.item(:portaria).show
            row.values numero_da_portaria: @requisicao.numero_da_portaria
         end


      end

      send_data report.generate, filename: 'requisicao.pdf',
                type: 'application/pdf',
                disposition: 'attachment'
   end

   # GET /requisicoes/new
   def new
      @requisicao = Requisicao.new
      @estado = Estado.find_by(:sigla => "AP")
      @cidades = @estado.cidades.collect { |c| [c.nome, c.id] }
      # @endereco = @requisicao.build_endereco
   end

   def listar_rota
      @requisicao = Requisicao.find(params[:requisicao_id])


      kml = KMLFile.new

      folder = KML::Folder.new(:name => "Destino da Requisição: #{@requisicao.numero}", :description => "Esta é uma Descrição")
      if @requisicao.rotas.count > 0

         @requisicao.rotas.each do |r|
            point = KML::Point.new :coordinates => {:lat => r.latitude,
                                                    :lng => r.longitude}
            place = KML::Placemark.new :geometry => point, :name => r.destino
            folder.features << place
         end

      elsif !@requisicao.endereco.nil?
         point = KML::Point.new :coordinates => {:lat => @requisicao.endereco.latitude,
                                                 :lng => @requisicao.endereco.longitude}
         place = KML::Placemark.new :geometry => point, :name => @requisicao.endereco.descricao
         folder.features << place
      end
      kml.objects << folder

      @requisicao.kml = kml.render
      @requisicao.save

      send_data @requisicao.kml


   end

   def lat_lng_cidade
      @cidade = Cidade.find(params[:cidade_id])
      response = []
      response << {:latitude => @cidade.latitude, :longitude => @cidade.longitude}
      render :json => {:response => response.compact}.as_json
   end


   def agendar
      @requisicao = Requisicao.new
      @estado = Estado.find_by(:sigla => "AP")
   end

   def requisicao_urgente
      @requisicao = Requisicao.new
      @estado = Estado.find_by(:sigla => "AP")
   end


   def teste
      @requisicao = Requisicao.new
      @estado = Estado.find_by(:sigla => "AP")
   end


   # GET /requisicoes/1/edit
   def edit
   end

   # POST /requisicoes
   # POST /requisicoes.json
   def agendar_requisicao

      @requisicao = Requisicao.new(requisicao_params)
      data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/', '-')} #{requisicao_params[:hora_ida]}")
      data_retorno = Time.zone.parse("#{requisicao_params[:data_volta].gsub('/', '-')} #{requisicao_params[:hora_volta]}")
      #data = DateTime.strptime("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]} Brasilia",date_and_time)
      @requisicao.inicio = data
      @requisicao.fim = data_retorno
      @requisicao.periodo_longo = true
      @requisicao.requisitante_id = current_user.pessoa.id

      respond_to do |format|
         if @requisicao.save
            #@requisicao.agendar
            format.html { redirect_to @requisicao, notice: 'A Requisição foi agendada com sucesso.' }
            format.json { render :show, status: :created, location: @requisicao }
         else
            @estado = Estado.find_by(:sigla => "AP")
            format.html { render :agendar }
            format.json { render json: @requisicao.errors, status: :unprocessable_entity }
         end
      end
   end

   def create
      @requisicao = Requisicao.new(requisicao_params)
      @endereco = requisicao_params[:endereco_attributes]

      date_and_time = '%m-%d-%Y %H:%M:%S %Z'
      data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/', '-')} #{requisicao_params[:hora_ida]}")
      data_retorno = Time.zone.parse("#{requisicao_params[:data_volta].gsub('/', '-')} #{requisicao_params[:hora_volta]}")
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

   def salvar_pessoa
      url=params[:url_volta]
#  @pessoa = Administracao::Pessoa.new(params[:pessoa])
      @tipo = nil
      @mensagem = nil

      if @pessoa.save
         @tipo = :notice
         @mensagem = "A Pessoa #{@pessoa.nome} foi Salva com sucesso!"
      else
         @tipo = :alert
         @mensagem = "Não foi Possível Salvar, Tente novamente"
      end
      redirect_to url, @tipo => @mensagem
   end

   def avaliar
      @requisicao = Requisicao.find(params[:requisicao_id])
      @avaliacao = @requisicao.avaliacoes.new(:texto => params[:avaliar][:texto], :tipo => params[:avaliar][:tipo], :avaliador => current_user)
      @mensagem = nil
      @tipo = nil
      if @avaliacao.save
         @mensagem = "Avaliação Efetuada"
         @tipo=:notice
      else
         @mensagem = "Erro ao fazer a Avaliação"
         @tipo=:alert
      end

      redirect_to requisicoes_url, @tipo => @mensagem
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
         format.html { redirect_to requisicoes_url, notice: 'A Requisição foi cancelada!' }
         format.json { head :no_content }
      end
   end

   def tipo_carga
      if params[:motivo_id] and !params[:motivo_id].blank?
         @motivo = Administracao::Motivo.find(params[:motivo_id])
      end
      if @motivo and @motivo.carga? and !@motivo.necessita_descricao?
         render :partial => "partial_carga"
      elsif @motivo and @motivo.carga? and @motivo.necessita_descricao?
         render :partial => "carga_descricao"
      elsif @motivo and @motivo.necessita_descricao?
         render :partial => "descricao"
      elsif !@motivo or !@motivo.carga? or params[:motivo_id].blank?
         render :nothing => true
      end
   end


   def relatorio_horas
      @veiculos = Administracao::Veiculo.all
      report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'relatorios', 'relatorio_horas_por_semana.tlf')


      @veiculos.each do |v|
         bhoras = v.banco_de_horas
         bhoras.each do |bh|
            report.list.add_row do |row|
               row.item(:semana).value bh.numero_semana
               row.values mes: bh.mes
               row.values ano: bh.ano
               row.values veiculo: v.id
               row.values modalidade: v.modalidade.nome
               row.values lote: v.lote.nome
               row.values horas: bh.horas_extras
            end
         end
      end

      send_data report.generate, filename: 'relatorio_horas.pdf',
                type: 'application/pdf',
                disposition: 'attachment'
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_requisicao
      @requisicao = Requisicao.find(params[:id])

   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def requisicao_params
      params.require(:requisicao).permit(:numero, :pernoite, :descricao, :numero_passageiros, :requisitante_id, :data_ida, :hora_ida, :periodo, :tipo_requisicao, :periodo_longo, :inicio, :fim, :posto_id, :preferencia_id, :data_volta, :hora_volta, :motivo_id, :tipo_carga, :rota_ids => [], :pessoa_ids => [], endereco_attributes: [:logradouro, :numero, :complemento, :estado_id, :cidade_id, :bairro_id, :cep, :endereco, :latitude, :longitude, :descricao])
   end

   def pessoa_params
      params.require(:pessoa).permit(:nome, :cpf, :email, :matricula, :cargo_id, :departamento_id, :empresa_id)
   end

   def load_requisicao
      @requisicao = Requisicao.new(requisicao_params)
      @estado = Estado.find_by(:sigla => "AP")
   end

   def load_pessoa
      @pessoa = Administracao::Pessoa.new(pessoa_params)
   end

   def load_pessoas
      @pessoas = Administracao::Pessoa.pode_ser_passageiro.accessible_by(current_ability).all
   end

end
