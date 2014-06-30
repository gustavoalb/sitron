json.array!(@mensagens) do |mensagem|
  json.extract! mensagem, :id, :texto, :remetente_id, :destinatario_id, :tipo_usuario, :lido, :objeto_id, :objeto_type
  json.url mensagem_url(mensagem, format: :json)
end
