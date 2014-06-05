# -*- encoding : utf-8 -*-
class Administracao::Veiculo < ActiveRecord::Base
  belongs_to :modalidade
  belongs_to :combustivel
  belongs_to :empresa
  has_many :patios

  mount_uploader :qrcode, ArtefatoUploader
  mount_uploader :codigo_de_barras, ArtefatoUploader

 # belongs_to :turno

  enum tipo: [:passeio,:utilitário, :motocicleta, :carga,:coletivo]

  enum direcao: [:"normal",:elétrica,:hidraulica,:eletrohidráulica]

  enum marca: [:cherry,:sundown,:audi,:chevrolet, :citroen, :fiat, :ford, :honda, :kia, :nissan, :peugeot, :renault, :toyota, :volkswagen, :yamaha]


 after_validation :gerar_code,:gerar_codigo_barras

 def para_qrcode
  qrcode = "id = '#{self.id}' AND empresa = '#{self.empresa.id}"
  return qrcode
    
 end


 def para_codigo_de_barras

  code = "#{self.id}&#{self.empresa.id}&#{self.placa}"
  code2 = Base64.encode64(code)
  
  return code2
    
 end


private 


def gerar_code
 
 qr = RQRCode::QRCode.new(self.para_qrcode, :size => 4, :level => :h )
 png = qr.to_img 
 caminho=%(#{Rails.root}/tmp/#{self.id}.png)
 png.resize(900, 900).save(caminho)
 file = File.open(caminho)
 self.qrcode = file
 File.delete(caminho)
end


def gerar_codigo_barras
 codigo_barras=RGhost::Document.new :paper => [10.3,2], :margin_right => 3
 caminho=%(#{Rails.root}/tmp/)
 codigo_barras.barcode_code128(self.para_codigo_de_barras, :text => {:size => 10, :offset => [0,-1], :enable => [:text] })
 codigo_barras.render :png, :filename => File.join(caminho,"#{self.para_codigo_de_barras}.png") , :resolution => 300
 file = File.open("#{caminho}/#{self.para_codigo_de_barras}.png")
 self.codigo_de_barras = file
 File.delete(file)
end


end
