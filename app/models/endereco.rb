# -*- encoding : utf-8 -*-
class Endereco < ActiveRecord::Base

	attr_accessor :nome_responsavel,:cidade_nome,:bairro_nome

	belongs_to :enderecavel,:polymorphic=>true
	belongs_to :bairro
	belongs_to :cidade
	belongs_to :estado

   geocoded_by :endereco_completo
   after_validation :geocode

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
