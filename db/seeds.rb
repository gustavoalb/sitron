# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
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
