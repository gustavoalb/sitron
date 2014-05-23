json.array!(@administracao_configuracoes) do |administracao_configuracao|
  json.extract! administracao_configuracao, :id, :index, :salvar_configuracao
  json.url administracao_configuracao_url(administracao_configuracao, format: :json)
end
