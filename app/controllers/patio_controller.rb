# -*- encoding : utf-8 -*-
class PatioController < ApplicationController
  include ActionController::Live

  before_action :patio_hoje

  def index
    @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
  end

  def relatorio_presencial

  end

  def imprimir_relatorio
    @veiculos = Administracao::Veiculo.order(:contrato_id)
    inicio = "#{params[:relatorio][:inicio].to_date}  00:00:00 -0300"
    fim = "#{params[:relatorio][:fim].to_date}  00:00:00 -0300"
    presenca = 0
    ausencia = 0
    @datas = {}
    @turno = {}
    dias = 1
    t = 1
    horas_normais = 0
    horas_extras = 0



    report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'relatorios', 'relatorio_semanal.tlf')



    report.start_new_page


    (inicio.to_datetime.to_i .. fim.to_datetime.to_i).step(1.day) do |date|
      @datas.merge!(dias.to_s=>Time.at(date).to_date.to_s_br,"s#{dias}"=>Time.at(date).strftime("%a"))
      dias +=1
    end

    report.list.header.item(:data1).value(@datas['1'].to_s)
    report.list.header.item(:data2).value(@datas['2'].to_s)
    report.list.header.item(:data3).value(@datas['3'].to_s)
    report.list.header.item(:data4).value(@datas['4'].to_s)
    report.list.header.item(:data5).value(@datas['5'].to_s)
    report.list.header.item(:data6).value(@datas['6'].to_s)
    report.list.header.item(:data7).value(@datas['7'].to_s)

    report.list.header.item(:periodo1).value(inicio.to_date.to_s_br)
    report.list.header.item(:periodo2).value(fim.to_date.to_s_br)

    @veiculos.each do |v|

      horas_extras = v.horas_extras_semanais(inicio.to_date.strftime('%U'),inicio.to_date.year).round(2)
      horas_normais = v.horas_normais_semanais(inicio.to_date.strftime('%U'),inicio.to_date.year).round(2)




      report.list.add_row do |row|
        row.values placa: v.placa
        row.values contrato: v.contrato.numero
        (inicio.to_datetime.to_i .. fim.to_datetime.to_i).step(1.day) do |date|
          p = Posto.na_data(Time.at(date).to_date).find_by(:veiculo_id=>v.id)
          if p
            presenca +=1
            if p.manha?
              row.values "m#{t}".to_sym=>File.join(Rails.root, 'app','assets','images','check.png')
            elsif p.tarde?
              row.values "t#{t}".to_sym=>File.join(Rails.root, 'app','assets','images','check.png')
            elsif p.noite?
              row.values "n#{t}".to_sym=>File.join(Rails.root, 'app','assets','images','check.png')
            end
            t+=1
          else
            ausencia +=1
          end
        end

        row.values presenca: presenca
        row.values faltas: ausencia
        row.values horas_e: horas_extras
        row.values horas_n: horas_normais
        row.values diarias: 0
      end
      presenca = 0
      ausencia = 0
      t = 1
      #  @turno = {}
    end


    send_data report.generate, filename: "#{inicio.to_date.to_s}ate#{fim.to_date.to_s}.pdf",
      type: 'application/pdf',
      disposition: 'attachment'

  end



  def controle_manual
    @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)

    @postos_comuns = @patio.postos.ativo.na_data(Time.zone.now).order("lote_id, position ASC")
    @postos_especiais = @patio.postos.especiais.na_data(Time.zone.now).order("lote_id, position ASC")
    @postos_no_patio = @postos_comuns + @postos_especiais
    ary = @postos_no_patio.collect{|c|c.veiculo_id}

    @postos_fora = Administracao::Veiculo.nao_entraram(ary)



  end


  def entrada
    @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC")
    @postos_especiais = Posto.especiais.na_data(Time.zone.now).order("lote_id, position ASC")
    @postos = @postos_comuns + @postos_especiais
  end


  def saida
    @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
  end




  def chat
    @mensagem = params[:posto][:mensagem]
    respond_to do |f|
      f.js
    end
  end



  def ordernar_veiculo
    @postos = Posto.all
    @postos.each do |atr|
      atr.position = params['veiculo'].index(atr.id.to_s) + 1
      atr.save!
    end
    render :nothing => true
  end

  def sair_patio
    @posto = Posto.find(params[:posto_id])
    @posto.saida = Time.zone.now
    @posto.sair_do_patio
    redirect_to entrada_patio_index_url
  end

  def adicionar_posto

    cod = params[:posto][:codigo_de_barras]
    codigo = "0#{cod[0,cod.size-1]}"
    @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)
    @ja_adicionado = nil
    posto = @patio.postos.find_by(:codigo=>codigo,:turno=>Posto.setar_turno(Time.zone.now))

    if !posto.nil?
      @ja_adicionado = true
    else

      veiculo = Administracao::Veiculo.where(:codigo=>codigo).first
      if veiculo
        @posto = @patio.postos.create!(:codigo=>codigo,:entrada=>Time.zone.now,:veiculo_id=>veiculo.id,:data_entrada=>Time.zone.now.to_date,:patio=>@patio,:modalidade_id=>veiculo.modalidade_id,:empresa_id=>veiculo.empresa_id,:contrato_id=>veiculo.contrato_id,:lote=>veiculo.lote,:turno=>Posto.setar_turno(Time.zone.now))
        @postos = Posto.ativo.na_data(Time.now).order("position ASC")
        @ja_adicionado = false
      else
        @nao_existe = true
      end
    end

    respond_to do |format|
      format.js
    end

  end


  def remover_posto
    cod = params[:posto][:codigo_de_barras]
    codigo = "0#{cod[0,cod.size-1]}"
    veiculo = Administracao::Veiculo.where(:codigo=>codigo).first
    @postos = @patio.postos.na_data(Time.zone.now).order("position ASC")
    @posto = @patio.postos.find_by(:codigo=>codigo)


    if @posto
      puts "TEM POSTO"
      @posto.saida = Time.zone.now
      if @posto.sair_do_patio
        veiculo = @posto.veiculo
        Administracao::BancoDeHora.definir_horas_extras(veiculo,@posto.saida.day,@posto.saida.strftime("%U"),@posto.saida.month,@posto.saida.year,@posto.saida.beginning_of_week,@posto.saida.end_of_week,@posto.horas_normais)
      else
        puts "PORQUE ESSA MERDA NAO SAI: #{@posto.errors}"
      end

    else
      @mensagem = "Nenhum posto foi encontrado com este código"
    end

    respond_to do |format|
      format.js
    end


  end




  def saida_servico
    if (params.has_key?(:posto))
      codigo = params[:posto][:codigo_de_barras]
      @requisicao = Requisicao.confirmada.find_by(:codigo=>codigo)
    else
      @requisicao = Requisicao.confirmada.find(params[:requisicao_id])
    end
    @mensagem = nil


    if @requisicao

      @patio = Administracao::Patio.na_data(Time.zone.now).first
      @posto = @requisicao.posto
      @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

      if @posto and @posto.saida_proxima?

        @servico = @requisicao.create_servico(:veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id, :empresa_id=>@posto.veiculo.empresa_id, :contrato_id=>@posto.veiculo.contrato_id,:lote=>@posto.veiculo.lote, :saida=> Time.zone.now,:valor_combustivel_centavos=>2.30)
        @posto.sair
        @requisicao.data_ida = Time.zone.now
        @requisicao.hora_ida = Time.zone.now
        @requisicao.ativar

      else
        @mensagem = "A Requisição já foi confirmada!"
      end

    else
      @mensagem = "Nenhuma requisição encontrada com este código ou a requisição já foi finalizada!"
    end


    respond_to do |format|
      format.js
    end


  end




  def chegada_servico
    codigo = params[:posto][:codigo_de_barras]
    @requisicao = Requisicao.confirmada.find_by(:codigo=>codigo)
    @mensagem = nil


    if @requisicao
      @patio = Administracao::Patio.na_data(Time.zone.now).first
      @posto = @requisicao.posto
      veiculo = @posto.veiculo
      @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

      if @posto and @posto.em_transito?
        @servico = Administracao::Servico.where(:requisicao_id=>@requisicao.id, :veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id).first
        @servico.chegada = Time.zone.now
        @servico.atendido = true
        if @servico.save
          @posto.estacionar
          @requisicao.data_volta = Time.zone.now
          @requisicao.hora_volta = Time.zone.now
          @requisicao.finalizar
        else
          @mensagem = "Erro ao Finalizar o Serviço!"
        end

      else
        @mensagem = "A Requisição aparentemente já encontra-se finalizada!"
      end

    else
      @mensagem = "Este não parece ser um codigo de barras válido ou a Requisição já foi finalizada!"
    end

    respond_to do |format|
      format.js
    end

  end


  private

  def patio_hoje
    @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)
  end



end
