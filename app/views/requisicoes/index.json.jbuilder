json.array!(@requisicoes) do |requisicao|
  json.extract! requisicao, :id, :numero, :tipo_deslocamento, :descricao, :requisitante_id, :data, :hora, :periodo, :periodo_longo, :inicio, :fim, :posto_id, :prefencia_id
  json.url requisicao_url(requisicao, format: :json)
end
