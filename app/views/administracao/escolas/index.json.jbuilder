json.array!(@administracao_escolas) do |administracao_escola|
  json.extract! administracao_escola, :id, :municipio_id, :dependencia_administrativa, :zona, :codigo, :nome, :telefone
  json.url administracao_escola_url(administracao_escola, format: :json)
end
