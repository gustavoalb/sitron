json.array!(@administracao_departamentos) do |administracao_departamento|
  json.extract! administracao_departamento, :id, :nome, :descricao, :entidade_id, :responsavel_id
  json.url administracao_departamento_url(administracao_departamento, format: :json)
end
