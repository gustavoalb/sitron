# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Tipo.create(:nome=>"Passeio")
Tipo.create(:nome=>"Pickup")
Tipo.create(:nome=>"Motocicleta")
Tipo.create(:nome=>"Caminhão")
Tipo.create(:nome=>"Kombi")
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
 Estado.delete_all
 Cidade.delete_all
module BRPopulate

  def self.states
  #  http = Net::HTTP.new('raw.github.com', 443); http.use_ssl = true
    JSON.parse File.read(Rails.root.join('lib','states.json'))

  end

  def self.capital?(city, state)
    city["nome"] == state["capital"]
  end

  def self.populate
    states.each do |state|
      state_obj = Estado.new(:sigla => state["acronym"], :nome => state["name"])
      state_obj.save

      state["cities"].each do |city|
        c = Cidade.new
        c.nome = city
        c.estado = state_obj
        c.capital = capital?(city, state)
        c.save
      end
    end
  end
end

BRPopulate.populate
puts "Cadastrados os Estados Brasileiros e as Cidades"
puts "-----"
c = Cidade.includes(:estado).where("estados.sigla = 'AP'").references(:estado).where(:nome=>"Macapá").first



c.bairros.create(:nome=>"Açaí")
c.bairros.create(:nome=>"Aeroporto")
c.bairros.create(:nome=>"Agua Fria")
c.bairros.create(:nome=>"Alpha Ville")
c.bairros.create(:nome=>"Alvorada")
c.bairros.create(:nome=>"Beirol")
c.bairros.create(:nome=>"Bela Ville")
c.bairros.create(:nome=>"Buritizal")
c.bairros.create(:nome=>"Cabralzinho")
c.bairros.create(:nome=>"Central")
c.bairros.create(:nome=>"Centro")
c.bairros.create(:nome=>"Congós")
c.bairros.create(:nome=>"Fazendinha")
c.bairros.create(:nome=>"Fonte Nova")
c.bairros.create(:nome=>"Goiabal")
c.bairros.create(:nome=>"Infraero I")
c.bairros.create(:nome=>"Infraero II")
c.bairros.create(:nome=>"Irmãos Platon")
c.bairros.create(:nome=>"Jardim Equatorial ")
c.bairros.create(:nome=>"Jardim Felicidade I")
c.bairros.create(:nome=>"Jardim Felicidade II")
c.bairros.create(:nome=>"Jardim Marco Zero  ")
c.bairros.create(:nome=>"Jesus De Nazaré")
c.bairros.create(:nome=>"Laguinho")
c.bairros.create(:nome=>"Laurindo Banha ")
c.bairros.create(:nome=>"Lot. Palmeiras ")
c.bairros.create(:nome=>"Marabaixo I")
c.bairros.create(:nome=>"Marabaixo II")
c.bairros.create(:nome=>"Marabaixo III")
c.bairros.create(:nome=>"Muca")
c.bairros.create(:nome=>"Nova Esperança")
c.bairros.create(:nome=>"Novo Buritizal")
c.bairros.create(:nome=>"Novo Horizonte")
c.bairros.create(:nome=>"Pacoval"'')
c.bairros.create(:nome=>"Paraíso")
c.bairros.create(:nome=>"Perpétuo Socorro")
c.bairros.create(:nome=>"Remédios I")
c.bairros.create(:nome=>"Renascer")
c.bairros.create(:nome=>"Renascer I")
c.bairros.create(:nome=>"Renascer II")
c.bairros.create(:nome=>"Santa Inês")
c.bairros.create(:nome=>"Santa Rita")
c.bairros.create(:nome=>"São Lázaro")
c.bairros.create(:nome=>"Sem Bairro")
c.bairros.create(:nome=>"Trem")
c.bairros.create(:nome=>"Universidade")
c.bairros.create(:nome=>"Vila Amazonas")
c.bairros.create(:nome=>"Vila Tropical")
c.bairros.create(:nome=>"Zerão")

puts "Cadastrados os Bairros de Macapá"

puts "Cadastrando Latitude e Longitude das Cidades"

c = Cidade.where(:nome=>"Amapá").first
c.latitude=2.05333
c.longitude=-50.79306
c.save!

c = Cidade.where(:nome=>"Calçoene").first
c.latitude=2.4975
c.longitude=-50.94861
c.save!

c = Cidade.where(:nome=>"Cutias").first
c.latitude=0.98611
c.longitude=-50.80222
c.save!


c = Cidade.where(:nome=>"Ferreira Gomes").first
c.latitude=0.85833
c.longitude=-51.18
c.save!

c = Cidade.where(:nome=>"Itaubal").first
c.latitude=0.71167
c.longitude=-50.8
c.save!

c = Cidade.where(:nome=>"Laranjal do Jari").first
c.latitude=-1.12
c.longitude=-52
c.save!

c = Cidade.where(:nome=>"Macapá").first
c.latitude=0.03889
c.longitude=-51.06639
c.save!

c = Cidade.where(:nome=>"Mazagão").first
c.latitude=-0.115
c.longitude=-51.28944
c.save!

c = Cidade.where(:nome=>"Oiapoque").first
c.latitude=3.84306
c.longitude=-51.835
c.save!

c = Cidade.where(:nome=>"Pedra Branca do Amapari").first
c.latitude=0.77806
c.longitude=-51.94361
c.save!

c = Cidade.where(:nome=>"Porto Grande").first
c.latitude=0.71333
c.longitude=-51.41333
c.save!

c = Cidade.where(:nome=>"Pracuúba").first
c.latitude=1.74333
c.longitude=-50.79139
c.save!

c = Cidade.where(:nome=>"Santana").first
c.latitude=-0.05833
c.longitude=-51.18167
c.save!

c = Cidade.where(:nome=>"Serra do Navio").first
c.latitude=0.89556
c.longitude=-52.00222
c.save!

c = Cidade.where(:nome=>"Tartarugalzinho").first
c.latitude=1.50556
c.longitude=-50.91194
c.save!

c = Cidade.where(:nome=>"Vitória do Jari").first
c.latitude=-0.91722
c.longitude=-52.40806
c.save!

m1 = Administracao::Modalidade.create(:nome=>"VEÍCULOS PARA PRESTAÇÃO CONTINUADA DO SERVIÇO", periodo_diario: 8, dias_mes: 22, com_motorista: true, com_combustivel: true, quilometragem_livre: true, mes_completo: false)
m1.lotes.create(:nome=>"Lote 01 - 0028/2014",:numero_postos=>8,:tipo=>"Passeio",:descricao=>"Tipo passeio, motor 1.0 gasolina ou álcool; capacidade 05 pessoas, 04 passageiros e 01 motorista; vidros e travas elétricos nas 04 portas, com disponibilidade para 08 (oito) horas de trabalho de segunda a sexta.")
m1.lotes.create(:nome=>"Lote 02 - 0030/2014",:numero_postos=>6,:tipo=>"Pick-up",:descricao=>"Veículo utilitário e de passageiros, carroceria pick-up, com cabine dupla; movido a diesel;tração 4x4;")
#m1.lotes.create(:nome=>"Lote 03",:numero_postos=>1,:tipo=>"Kombi",:descricao=>"Veículo coletivo tipo Kombi; gasolina ou álcool, 03 portas, capacidade para 08 ou mais pessoas")
m1.lotes.create(:nome=>"Lote 04 - 0027/2014",:numero_postos=>2,:tipo=>"Caminhão",:descricao=>"Veículo de carga, tipo Caminhão, motor a diesel; 04 cilindros;categoria básica com capacidade para 10 a 12 toneladas;")
m1.lotes.create(:nome=>"Lote 05 - 0029/2014",:numero_postos=>3,:tipo=>"Motocicleta",:descricao=>"Veículo tipo Motocicleta")
#m1.lotes.create(:nome=>"Lote 06",:numero_postos=>1,:tipo=>"Van",:descricao=>"Veículo coletivo, tipo Van; motor a diesel; 03 portas laterais; com capacidade mínima de 16 dezesseis lugares; 15 passageiros e um motorista")

#m2 = Administracao::Modalidade.create(nome: "VEÍCULOS PARA PRESTAÇÃO CONTINUADA DO SERVIÇO", periodo_diario: 24, dias_mes: 30, com_motorista: false, com_combustivel: false, quilometragem_livre: true, mes_completo: false)
#m2.lotes.create(:nome=>"Lote 01",:numero_postos=>2,:tipo=>"Passeio",:descricao=>"Tipo passeio, motor 1.0 gasolina ou álcool; capacidade 05 pessoas, 04 passageiros e 01 motorista; vidros e travas elétricos nas 04 portas, com disponibilidade para 08 (oito) horas de trabalho de segunda a sexta.")
#m2.lotes.create(:nome=>"Lote 02",:numero_postos=>2,:tipo=>"Pick-up",:descricao=>"Veículo utilitário e de passageiros, carroceria pick-up, com cabine dupla; movido a diesel;tração 4x4;")
#m2.lotes.create(:nome=>"Lote 03",:numero_postos=>1,:tipo=>"Kombi",:descricao=>"Veículo coletivo tipo Kombi; gasolina ou álcool, 03 portas, capacidade para 08 ou mais pessoas")
