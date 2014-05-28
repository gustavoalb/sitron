json.array!(@administracao_veiculos) do |administracao_veiculo|
  json.extract! administracao_veiculo, :id, :tipo, :motor, :diracao, :marca, :modelo, :capacidade_carga, :capacidade_passageiros, :ano_fabricacao, :ano_modelo, :intens_obrigatorios, :observacao, :modalidade_id, :combustivel_id, :turno_id
  json.url administracao_veiculo_url(administracao_veiculo, format: :json)
end
