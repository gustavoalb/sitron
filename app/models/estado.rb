# -*- encoding : utf-8 -*-
class Estado < ActiveRecord::Base
	has_many :cidades
	validates_uniqueness_of :sigla
end
