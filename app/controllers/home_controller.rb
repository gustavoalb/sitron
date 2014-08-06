# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
	

	def nao_autorizado
	end

	def busca
		@query = params[:busca][:nome] if params[:busca]
		@busca_pessoas = Search.new(Administracao::Pessoa.accessible_by(current_ability), params[:busca])
		@busca_pessoas.order = 'nome'
		@pessoas = @busca_pessoas.run

		add_breadcrumb("Busca",nil,:icon=>"dashboard")
	end

	def manual


		 File.open(File.join(Rails.root, 'app', 'relatorios', 'manual.pdf'), 'rb') do |f|
		 	send_data f.read, :type => "application/pdf", :disposition => "inline"
		 end
	end
end
