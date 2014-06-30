json.array!(@administracao_motivos) do |administracao_motivo|
  json.extract! administracao_motivo, :id, :nome, :tipo_id, :carga, :passageiro, :entrega_documento, :interior, :viagem_longa
  json.url administracao_motivo_url(administracao_motivo, format: :json)
end
