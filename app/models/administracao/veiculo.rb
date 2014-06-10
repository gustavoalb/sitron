# -*- encoding : utf-8 -*-
class Administracao::Veiculo < ActiveRecord::Base
  belongs_to :modalidade
  belongs_to :combustivel
  belongs_to :empresa
  belongs_to :tipo
  has_many :patios

  mount_uploader :qrcode, ArtefatoUploader
  mount_uploader :codigo_de_barras, ArtefatoUploader

 # belongs_to :turno

  

  enum direcao: [:"normal",:elétrica,:hidraulica,:eletrohidráulica]

  enum marca: [:cherry,:sundown,:audi,:chevrolet, :citroen, :fiat, :ford, :honda, :kia, :nissan, :peugeot, :renault, :toyota, :volkswagen, :yamaha]

 after_create :gerar_code
 
 before_create :gerar_codigo_barras

 def para_qrcode
  qrcode = "id = '#{self.id}' AND empresa_id = '#{self.empresa.id}'"
  return qrcode
    
 end


 def self.gerar_codigo_de_barras

  code = "#{rand(9999999).to_s}"
  code2 = ""
  code3 = ""

  case code.length
  when 7
      code2 = code+"#{rand(999999)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 8
      code2 = code+"#{rand(99999)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 9
      code2 = code+"#{rand(9999)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 10
      code2 = code+"#{rand(999)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 11
      code2 = code+"#{rand(99)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 12
      code2 = code+"#{rand(9)}"
      code3 = "#{code2}#{code2.generate_check_digit}"
    when 13
      code2 = code
      code3 = "#{code2}#{code2.generate_check_digit}"
    else
      '00000000000000'
    end
  
  return code3
    
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
 self.save
end


def gerar_codigo_barras
 codigo = Administracao::Veiculo.gerar_codigo_de_barras
 codigo_barras=RGhost::Document.new :paper => [10.3,2], :margin_right => 3
 caminho=%(#{Rails.root}/tmp/)
 codigo_barras.barcode_code128(codigo, :text => {:size => 10, :offset => [0,-1], :enable => [:text] })
 codigo_barras.render :png, :filename => File.join(caminho,"#{codigo}.png") , :resolution => 300
 file = File.open("#{caminho}/#{codigo}.png")
 self.codigo_de_barras = file
 self.codigo = codigo
 File.delete(file)
end


end
