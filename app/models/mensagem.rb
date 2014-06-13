class Mensagem < ActiveRecord::Base
  belongs_to :remetente,class_name: "User"
  belongs_to :destinatario,class_name: "User"
  belongs_to :objeto,:polymorphic=>true
  scope :tipo_usuario,lambda{|tipo| where(:tipo_usuario=>tipo)}
  scope :para_o_usuario,lambda {|u| where(:destinatario_id=>u.id)}
  scope :nao_lidas, ->{where(:state=>:nao_lida)}


  state_machine :initial => :nao_lida do

  event :ler do
    transition :nao_lida => :lida
   end

   event :nao_ler do
    transition :lida => :nao_lida
   end

   end

end
