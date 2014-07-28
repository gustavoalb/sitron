class Administracao::BancoDeHora < ActiveRecord::Base
	belongs_to :posto
	belongs_to :veiculo

	scope :no_dia,lambda{|dia| where(:dia=>dia)}
	scope :no_mes,lambda{|mes| where(:mes=>mes)}
	scope :no_ano,lambda{|ano| where(:ano=>ano)}
	scope :na_semana,lambda{|semana| where(:numero_semana=>semana)}



	def self.definir_horas_extras(veiculo,dia,numero_semana,mes,ano,inicio_semana,fim_semana,horas,horas_n=nil)

		banco_hora = Administracao::BancoDeHora.where(veiculo_id: veiculo.id, numero_semana: numero_semana, mes: mes,ano: ano).first

		if banco_hora
			banco_horas2 = Administracao::BancoDeHora.where(veiculo_id: veiculo.id, dia: dia,numero_semana: numero_semana, mes: mes,ano: ano).first
			horas_extras = banco_horas2.horas_extras 
			horas_normais = banco_horas2.horas_normais
			if horas_extras and horas_extras > 0
				horas_extras+=horas
				banco_horas2.horas_extras = horas_extras
				banco_horas2.save!
			else
				horas_extras = horas 
				banco_horas2.horas_extras = horas_extras
				banco_horas2.save!
			end

			if horas_normais and horas_normais > 0
				horas_normais+=horas_n
				banco_horas2.horas_normais = horas_normais
				banco_horas2.save!
			else
				horas_normais = horas_n 
				banco_horas2.horas_normais = horas_normais
				banco_horas2.save!
			end



		else 
			inicio = inicio_semana
			fim    = fim_semana

    	(inicio.to_datetime.to_i .. fim.to_datetime.to_i).step(1.day) do |date| #interage na data
    		if Time.at(date).day == dia and Time.at(date).month == mes and Time.at(date).year == ano
    			banco_hora = Administracao::BancoDeHora.create(veiculo: veiculo,dia: Time.at(date).day,numero_semana: numero_semana,mes: mes,ano: ano,inicio_semana: inicio,fim_semana: fim,horas_extras: horas, horas_normais:horas_n)
    		else
    			banco_hora = Administracao::BancoDeHora.create(veiculo: veiculo,dia: Time.at(date).day,numero_semana: numero_semana,mes: mes,ano: ano,inicio_semana: inicio,fim_semana: fim)
    		end		
    	end



    end

end






end
