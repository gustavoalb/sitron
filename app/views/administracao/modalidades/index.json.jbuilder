json.array!(@administracao_modalidades) do |administracao_modalidade|
  json.extract! administracao_modalidade, :id, :nome, :periodo_diario, :dias_mes, :com_motorista, :com_combustivel, :quilometragem_livre, :mes_completo
  json.url administracao_modalidade_url(administracao_modalidade, format: :json)
end
