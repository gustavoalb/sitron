# -*- encoding : utf-8 -*-
class Administracao::Combustivel < ActiveRecord::Base

register_currency :brl

monetize :valor_centavos, :with_currency => :brl

end
