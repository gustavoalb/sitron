# -*- encoding : utf-8 -*-
class Estado < ActiveRecord::Base
	has_many :cidades
end
