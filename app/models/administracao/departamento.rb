class Administracao::Departamento < ActiveRecord::Base
  belongs_to :entidade,:class_name=>"Empresa"
  belongs_to :responsavel,:class_name=>"Pessoa"
  has_one :endereco,:as=>:enderecavel
  has_one :rota, :as=>:roteavel
  

  attr_accessor :nome_responsavel,:cidade_nome,:bairro_nome

  after_create :adicionar_rota
  after_update :editar_rota


  accepts_nested_attributes_for :endereco#, :reject_if => proc { |attributes| attributes['logradouro'].blank? },:allow_destroy => true


	
	private

	def adicionar_rota
		rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"Rota para o Departamento #{self.nome}")
    end

    def editar_rota
		rota = self.rota 
		rota.latitude = self.endereco.latitude
		rota.longitude = self.endereco.longitude
		rota.save
    end




end
