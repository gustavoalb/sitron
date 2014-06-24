json.array!(@administracao_contratos) do |administracao_contrato|
  json.extract! administracao_contrato, :id, :numero, :empresa_id, :lei, :artigo
  json.url administracao_contrato_url(administracao_contrato, format: :json)
end
