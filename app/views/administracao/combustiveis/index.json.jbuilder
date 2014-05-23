json.array!(@administracao_combustiveis) do |administracao_combustivel|
  json.extract! administracao_combustivel, :id, :nome, :valor
  json.url administracao_combustivel_url(administracao_combustivel, format: :json)
end
