json.array!(@administracao_banco_de_horas) do |administracao_banco_de_hora|
  json.extract! administracao_banco_de_hora, :id, :posto_id, :dia, :mes, :ano, :horas_normais, :horas_extras, :numero_semana, :inicio_semana, :fim_semana
  json.url administracao_banco_de_hora_url(administracao_banco_de_hora, format: :json)
end
