# -*- encoding : utf-8 -*-
class Administracao::Departamento < ActiveRecord::Base
  belongs_to :entidade,:class_name=>"Empresa"
  belongs_to :responsavel,:class_name=>"Pessoa"
  has_one :endereco,:as=>:enderecavel,:dependent=>:destroy
  has_one :rota, :as=>:roteavel,:dependent=>:destroy


  

  attr_accessor :nome_responsavel,:cidade_nome,:bairro_nome

  after_create :adicionar_rota
  after_update :editar_rota
  
  scope :com_responsavel,->{where("responsavel_id > 0")}

  accepts_nested_attributes_for :endereco#, :reject_if => proc { |attributes| attributes['logradouro'].blank? },:allow_destroy => true



  def codigo_departamento

    code =  self.id.to_s

    case code.chars.count
    when 1
      code_d = "00#{code}"
    when 2
      code_d = "0#{code}"
    else
      code_d = "#{code}"
    end
    return code_d
  end

  private

  def adicionar_rota
    if self.e_um_destino?
      rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"#{self.nome}")
    end
  end

  def editar_rota
    rota = self.rota 
    if rota 
      if rota.latitude != self.endereco.latitude and rota.longitude != self.endereco.longitude
        rota.latitude = self.endereco.latitude
        rota.longitude = self.endereco.longitude
        rota.save
      end
    else
      if self.e_um_destino?
        rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"#{self.nome}")
      end
    end
  end




end
