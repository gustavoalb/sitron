json.array!(@administracao_rotas) do |administracao_rota|
  json.extract! administracao_rota, :id, :destino, :entidade_id, :tempo_previsto, :latitude, :longitude, :rota_longa, :intermunicipal
  json.url administracao_rota_url(administracao_rota, format: :json)
end
