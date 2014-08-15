# -*- encoding : utf-8 -*-
class Administracao::Servico < ActiveRecord::Base
  belongs_to :requisicao
  belongs_to :veiculo
  belongs_to :user

  register_currency :brl

  monetize :valor_combustivel_centavos, :with_currency => :brl
end
