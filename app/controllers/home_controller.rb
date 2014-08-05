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
end
