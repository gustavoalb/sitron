# -*- encoding : utf-8 -*-
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
class Administracao::Veiculo < ActiveRecord::Base
  belongs_to :modalidade
  belongs_to :combustivel
  belongs_to :empresa
  belongs_to :tipo
  belongs_to :contrato
  has_many :patios
  belongs_to :lote

  mount_uploader :qrcode, ArtefatoUploader
  mount_uploader :codigo_de_barras, ArtefatoUploader
  mount_uploader :codigo_de_barras_s, ArtefatoUploader
 # belongs_to :turno

 validates_presence_of :lote_id,:contrato_id,:empresa_id



 enum direcao: [:"normal",:elétrica,:hidraulica,:eletrohidráulica]

 enum marca: [:cherry,:sundown,:audi,:chevrolet, :citroen, :fiat, :ford, :honda, :kia, :nissan, :peugeot, :renault, :toyota, :volkswagen, :yamaha]

 #enum lote:  [:"Lote 01",:"Lote 02",:"Lote 03",:"Lote 04",:"Lote 05",:"Lote 06",:"Lote 07",:"Lote 08",:"Lote único"]

 after_create :gerar_code
 
 #before_create :gerar_codigo_barras

 def para_qrcode
  qrcode = "id = '#{self.id}' AND empresa_id = '#{self.empresa.id}'"
  return qrcode
end


def codigo_carro

  code =  self.id.to_s

  case code.chars.count
  when 1
    code_car = "000#{code}"
      #code3 = "#{code2}#{code2.generate_check_digit}"
    when 2
      code_car = "00#{code}"
    when 3
      code_car = "0#{code}"
    when 4
      code_car = "#{code}"
    else
      code_car = "#{code}"
    end
    return code_car
  end





#private 


  def gerar_code

   qr = RQRCode::QRCode.new(self.para_qrcode, :size => 4, :level => :h )
   png = qr.to_img 
   caminho=%(#{Rails.root}/tmp/#{self.id}.png)
   png.resize(900, 900).save(caminho)
   file = File.open(caminho)
   self.qrcode = file
   File.delete(caminho)

   ean = "N1#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
   codigo = "#{ean}#{ean.generate_check_digit}"

   ean1 = "S1#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
   codigo1 = "#{ean1}#{ean1.generate_check_digit}"

   ean2 = "S2#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
   codigo2 = "#{ean2}#{ean2.generate_check_digit}"

   ean3 = "S3#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
   codigo3 = "#{ean3}#{ean3.generate_check_digit}"

   barcode = Barby::Code128B.new(codigo)
   barcode1 = Barby::Code128B.new(codigo1)
   barcode2 = Barby::Code128B.new(codigo2)
   barcode3 = Barby::Code128B.new(codigo3)

   caminho=%(#{Rails.root}/tmp)

   File.open("#{caminho}/#{codigo}.png",'w'){|f|f.write barcode.to_png(margin: 0)}
   file = File.open("#{caminho}/#{codigo}.png")
   self.codigo_de_barras = file
   File.delete(file)


   File.open("#{caminho}/#{codigo1}.png",'w'){|f|f.write barcode1.to_png(margin: 0)}
   file1 = File.open("#{caminho}/#{codigo1}.png")
   self.codigo_de_barras_s = file1
   File.delete(file1)

   

   self.codigo = codigo
   self.codigo_s = codigo1
   self.save!
 end




end