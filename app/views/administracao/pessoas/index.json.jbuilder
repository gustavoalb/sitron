json.array!(@administracao_pessoas) do |administracao_pessoa|
  json.extract! administracao_pessoa, :id, :nome, :cpf, :email, :matricula, :cargo_id
  json.url administracao_pessoa_url(administracao_pessoa, format: :json)
end
