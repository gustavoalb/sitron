# -*- encoding : utf-8 -*-
class Administracao::BancoDeHora < ActiveRecord::Base
	belongs_to :posto
	belongs_to :veiculo

	scope :no_dia,lambda{|dia| where(:dia=>dia)}
	scope :no_mes,lambda{|mes| where(:mes=>mes)}
	scope :no_ano,lambda{|ano| where(:ano=>ano)}
	scope :na_semana,lambda{|semana| where(:numero_semana=>semana)}


	def self.resetar_horas_semana(veiculo,numero_semana,mes,ano)
		banco_hora = Administracao::BancoDeHora.find_by(veiculo_id: veiculo.id, numero_semana: numero_semana, mes: mes,ano: ano)
		if banco_hora
			banco_hora.horas_normais = 0.0
			banco_hora.horas_extras = 0.0
			banco_hora.save!
			return true
		else
			return false
		end
	end



	def self.definir_horas_extras(veiculo,dia,numero_semana,mes,ano,inicio_semana,fim_semana,minutos)
		horas = (minutos/60)
		mins = minutos

		banco_hora = Administracao::BancoDeHora.find_by(veiculo_id: veiculo.id, numero_semana: numero_semana, mes: mes,ano: ano)
		semanais =  Administracao::BancoDeHora.where(veiculo_id: veiculo.id, numero_semana: numero_semana, mes: mes,ano: ano).all
		
		if banco_hora
			banco_horas2 = Administracao::BancoDeHora.where(veiculo_id: veiculo.id, dia: dia,numero_semana: numero_semana, mes: mes,ano: ano).first
			horas_normais = banco_horas2.horas_normais
			horas_extras = banco_horas2.horas_extras

			horas_extras_semanais = 0.0

			semanais.each do |h|
				horas_extras_semanais += h.horas_extras
			end


			if (horas_normais+horas) > 8

				hora_extra =  ((horas_normais+horas)-8)
				hora_normal = (((horas_normais+horas)-hora_extra)-horas_normais)
				banco_horas2.horas_normais += hora_normal

				if (horas_extras_semanais + hora_extra) < 8
					banco_horas2.horas_extras += hora_extra
				elsif (horas_extras_semanais < 8) and (horas_extras_semanais + hora_extra) > 8
					hora_extra2 =  ((horas_extras_semanais+hora_extra)-8)
					acumulo = (((horas_extras_semanais+hora_extra)-hora_extra2)-hora_extra)
					banco_horas2.acumulo_horas_extras += acumulo
					banco_horas2.horas_extras+=hora_extra2
				else
					banco_horas2.acumulo_horas_extras += hora_extra
				end




				banco_horas2.save


			else 

				banco_horas2.horas_normais+=horas
				banco_horas2.save

			end



		else 

			inicio = inicio_semana
			fim    = fim_semana

    	(inicio.to_datetime.to_i .. fim.to_datetime.to_i).step(1.day) do |date| #interage na data
    		if Time.at(date).day == dia and Time.at(date).month == mes and Time.at(date).year == ano
    			banco_hora = Administracao::BancoDeHora.create(veiculo: veiculo,dia: Time.at(date).day,numero_semana: numero_semana,mes: mes,ano: ano,inicio_semana: inicio,fim_semana: fim, horas_normais:horas,minutos:mins)
    		else
    			banco_hora = Administracao::BancoDeHora.create(veiculo: veiculo,dia: Time.at(date).day,numero_semana: numero_semana,mes: mes,ano: ano,inicio_semana: inicio,fim_semana: fim)
    		end		
    	end



    end

end






end
