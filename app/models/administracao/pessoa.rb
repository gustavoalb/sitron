class Administracao::Pessoa < ActiveRecord::Base
	belongs_to :cargo
	belongs_to :entidade,:class_name=>"Empresa"
	belongs_to :user
	belongs_to :departamento
	has_many :requisicoes,:foreign_key=>"requisitante_id"


#after_validation :gerar_usuario

	def gerar_email
		email=''
		palavras = self.nome.remover_acentos.split(/\W+/)
		if palavras.size > 2
			email = "#{palavras.first}.#{palavras.second}.#{palavras.last}".downcase
		else
			email ="#{palavras.first}.#{palavras.last}".downcase
		end
		return email

	end



private
	def gerar_usuario
		if self.user.nil?
			if !self.cpf.nil? and !self.nome.nil?
				@user = self.create_user(:role=>:funcionario,:cpf=>self.cpf.gsub(".","").gsub("-",""), :nome=>self.nome,:password=>self.cpf.gsub(".","").gsub("-",""),:password_confirmation=>self.cpf.gsub(".","").gsub("-",""),:email=>"#{self.gerar_email}@seed.ap.gov.br")
				@user.save!
			else
				@user = "Erro ao Criar Usuário #{self.id}"
			end
		end
		return @user
	end

end
