# -*- encoding : utf-8 -*-
require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/ean_13'
require 'barby/barcode/code_39'
require 'barby/outputter/png_outputter'
class Administracao::Veiculo < ActiveRecord::Base
 include HasBarcode
 belongs_to :modalidade
 belongs_to :combustivel
 belongs_to :empresa
 belongs_to :tipo
 belongs_to :contrato
 has_many :patios
 belongs_to :lote
 has_many :banco_de_horas,:dependent=>:nullify
 has_many :provisoes,:dependent=>:nullify

 mount_uploader :qrcode, ArtefatoUploader
 mount_uploader :codigo_de_barras, ArtefatoUploader
 mount_uploader :codigo_de_barras_s, ArtefatoUploader
 acts_as_list scope: [:lote]



 has_barcode :barcode,
 :outputter => :png,
 :type => Barby::EAN13,
 :value => Proc.new { |v| v.numero }




 # belongs_to :turno

 validates_presence_of :lote_id,:contrato_id,:empresa_id



 enum direcao: [:"normal",:elétrica,:hidraulica,:eletrohidráulica]

 enum marca: [:cherry,:sundown,:audi,:chevrolet, :citroen, :fiat, :ford, :honda, :kia, :nissan, :peugeot, :renault, :toyota, :volkswagen, :yamaha]

 #enum lote:  [:"Lote 01",:"Lote 02",:"Lote 03",:"Lote 04",:"Lote 05",:"Lote 06",:"Lote 07",:"Lote 08",:"Lote único"]

 after_create :gerar_code
 
 #before_create :gerar_codigo_barras


 def horas_extras_semanais(semana,ano)
  banco_de_horas = self.banco_de_horas.na_semana(semana).no_ano(ano)
  
  horas_extras = 0.0

  banco_de_horas.each do |b|
    if b.horas_extras
      horas_extras += b.horas_extras
    end

  end

  return horas_extras

end


def validar_horas_extras(horas,semana,mes,ano)
 horas_extras = self.horas_extras_semanais(semana,ano)

 if horas_extras == 8.0 
  return false
else

  if horas_extras + horas > 8.0 
    return false 
  elsif horas_extras + horas <=8.0
    return true
  end

end
end

def aprovisionado?(data) 
  if self.provisoes.na_data(data).size > 0
    return true
  else
    return false
  end
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
    else
      code_car = "#{code}"
    end
    return code_car
  end

  def numero
    ean =  "#{self.codigo_carro}#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
    codigo = "#{ean}#{ean.generate_check_digit}"
    return codigo
  end





#private 


def gerar_code



 ean = "#{self.codigo_carro}#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
 codigo = "#{ean}#{ean.generate_check_digit}"

 qr = RQRCode::QRCode.new(self.codigo, :size => 4, :level => :h )
 png = qr.to_img 
 caminho=%(#{Rails.root}/tmp/#{self.id}.png)
 png.resize(900, 900).save(caminho)
 file = File.open(caminho)
 self.qrcode = file
 File.delete(caminho)

 ean1 = "S1#{self.modalidade.codigo_modalidade}#{self.contrato.codigo_contrato}#{self.lote_id}"
 codigo1 = "#{ean1}#{ean1.generate_check_digit}"


 #barcode = Barby::Code128B.new(codigo)


 caminho=%(#{Rails.root}/tmp)

 File.open("#{caminho}/#{codigo.upcase}.png",'w'){|f|f.write self.barcode.to_png(:xdim=>3,:height=>150,margin: 0)}
 file = File.open("#{caminho}/#{codigo.upcase}.png")
 self.codigo_de_barras = file
 File.delete(file)




 self.codigo = codigo
 self.save!
end




end
