json.array!(@notificacoes) do |notificacao|
  json.extract! notificacao, :id, :texto, :motivo, :state, :origem_id, :entidade_id, :posto_id
  json.url notificacao_url(notificacao, format: :json)
end
