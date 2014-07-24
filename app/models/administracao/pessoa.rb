class Administracao::Pessoa < ActiveRecord::Base
	default_scope { where(visivel: true) }
	belongs_to :cargo
	belongs_to :entidade,:class_name=>"Empresa"
	belongs_to :user
	belongs_to :departamento
	has_many :requisicoes,:foreign_key=>"requisitante_id",:dependent=>:destroy


	validates_presence_of :nome, :email


	def codigo_pessoa

		code =  self.id.to_s

		case code.chars.count
		when 1
			code_p = "000#{code}"
		when 2
			code_p = "00#{code}"
		when 3
			code_p = "0#{code}"
		else
			code_p = "#{code}"
		end
		return code_p
	end


#after_validation :gerar_usuario

# 	def gerar_email
# 		email=''
# 		palavras = self.nome.remover_acentos.split(/\W+/)
# 		if palavras.size > 2
# 			email = "#{palavras.first}.#{palavras.second}.#{palavras.last}".downcase
# 		else
# 			email ="#{palavras.first}.#{palavras.last}".downcase
# 		end
# 		return email

# 	end



# private
# 	def gerar_usuario
# 		if self.user.nil?
# 			if !self.cpf.nil? and !self.nome.nil?
# 				@user = self.create_user(:role=>:funcionario,:cpf=>self.cpf.gsub(".","").gsub("-",""), :nome=>self.nome,:password=>self.cpf.gsub(".","").gsub("-",""),:password_confirmation=>self.cpf.gsub(".","").gsub("-",""),:email=>"#{self.gerar_email}@seed.ap.gov.br")
# 				@user.save!
# 			else
# 				@user = "Erro ao Criar Usuário #{self.id}"
# 			end
# 		end
# 		return @user
# 	end

end
