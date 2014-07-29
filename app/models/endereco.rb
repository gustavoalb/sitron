# -*- encoding : utf-8 -*-
class Endereco < ActiveRecord::Base

	attr_accessor :nome_responsavel,:cidade_nome,:bairro_nome

	belongs_to :enderecavel,:polymorphic=>true
	belongs_to :bairro
	belongs_to :cidade
	belongs_to :estado

    validates_presence_of :descricao, :message=>"Precisa informar a descrição do destino",if: Proc.new { |e| e.enderecavel_type? and e.enderecavel_type == "Requisicao" }




   #geocoded_by :endereco_completo
 #  after_validation :reverse_geocode
 #  reverse_geocoded_by :latitude, :longitude, :address => :logradouro

	enum tipo:  [
		"Outros",
		"Aeroporto",
		"Alameda",
		"Área",
		"Avenida",
		"Campo",
		"Chácara",
		"Colônia",
		"Condomínio",
		"Conjunto",
		"Distrito",
		"Esplanada",
		"Estação",
		"Estrada",
		"Favela",
		"Fazenda",
		"Feira",
		"Jardim",
		"Ladeira",
		"Lago",
		"Lagoa",
		"Largo",
		"Loteamento",
		"Morro",
		"Núcleo",
		"Parque",
		"Passarela",
		"Pátio",
		"Praça",
		"Quadra",
		"Recanto",
		"Residencial",
		"Rodovia",
		"Rua",
		"Setor",
		"Sítio",
		"Travessa",
		"Trecho",
		"Trevo",
		"Vale",
		"Vereda",
		"Via",
		"Viaduto",
		"Viela",
		"Vila"
	]
def endereco_completo
["#{logradouro},#{numero}", cidade.nome, estado.sigla, 'BR'].compact.join(', ')   
end

end
