json.array!(@administracao_empresas) do |administracao_empresa|
  json.extract! administracao_empresa, :id, :nome, :cnpj, :endereco_id, :responsavel_id
  json.url administracao_empresa_url(administracao_empresa, format: :json)
end
