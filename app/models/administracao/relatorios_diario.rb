class Administracao::RelatoriosDiario < ActiveRecord::Base

	enum tipo: [:usuario, :sistema, :rede,:veiculo]
end
