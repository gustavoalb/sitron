json.array!(@administracao_relatorios_diarios) do |administracao_relatorios_diario|
  json.extract! administracao_relatorios_diario, :id, :tipo, :descricao, :data
  json.url administracao_relatorios_diario_url(administracao_relatorios_diario, format: :json)
end
