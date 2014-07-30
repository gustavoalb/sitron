# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140730142526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avaliacoes", force: true do |t|
    t.integer  "requisicao_id"
    t.text     "texto"
    t.integer  "tipo"
    t.integer  "avaliador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "avaliacoes", ["avaliador_id"], name: "index_avaliacoes_on_avaliador_id", using: :btree
  add_index "avaliacoes", ["requisicao_id"], name: "index_avaliacoes_on_requisicao_id", using: :btree

  create_table "bairros", force: true do |t|
    t.string   "nome"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bairros", ["nome"], name: "index_bairros_on_nome", using: :btree

  create_table "banco_de_horas", force: true do |t|
    t.integer  "posto_id"
    t.integer  "veiculo_id"
    t.integer  "dia"
    t.integer  "mes"
    t.integer  "ano"
    t.integer  "numero_semana"
    t.date     "inicio_semana"
    t.date     "fim_semana"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "minutos"
    t.float    "horas_normais",        default: 0.0
    t.float    "horas_extras",         default: 0.0
    t.float    "acumulo_horas_extras"
  end

  add_index "banco_de_horas", ["posto_id"], name: "index_banco_de_horas_on_posto_id", using: :btree
  add_index "banco_de_horas", ["veiculo_id"], name: "index_banco_de_horas_on_veiculo_id", using: :btree

  create_table "cargos", force: true do |t|
    t.string   "nome"
    t.integer  "entidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cargos", ["entidade_id"], name: "index_cargos_on_entidade_id", using: :btree

  create_table "cidades", force: true do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.boolean  "capital",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",   default: 0.6123044764332252
    t.float    "longitude",  default: -51.3437641853028
  end

  add_index "cidades", ["nome"], name: "index_cidades_on_nome", using: :btree

  create_table "combustiveis", force: true do |t|
    t.string   "nome"
    t.integer  "valor_centavos"
    t.string   "valor_currency", default: "BRL", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuracoes", force: true do |t|
    t.string   "skin"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contratos", force: true do |t|
    t.string   "numero"
    t.integer  "empresa_id"
    t.string   "lei"
    t.string   "artigo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "inicio_vigencia"
    t.date     "fim_vigencia"
  end

  add_index "contratos", ["empresa_id"], name: "index_contratos_on_empresa_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departamentos", force: true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.integer  "entidade_id"
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sigla"
    t.boolean  "e_um_destino",   default: false
  end

  add_index "departamentos", ["entidade_id"], name: "index_departamentos_on_entidade_id", using: :btree
  add_index "departamentos", ["responsavel_id"], name: "index_departamentos_on_responsavel_id", using: :btree

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.string   "cnpj"
    t.integer  "endereco_id"
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome_responsavel"
  end

  create_table "enderecos", force: true do |t|
    t.string   "logradouro"
    t.string   "numero"
    t.string   "complemento"
    t.string   "cep"
    t.integer  "bairro_id"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.float    "latitude",         default: 0.6123044764332252
    t.float    "longitude",        default: -51.3437641853028
    t.integer  "enderecavel_id"
    t.string   "enderecavel_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "endereco"
    t.string   "descricao"
  end

  add_index "enderecos", ["latitude"], name: "index_enderecos_on_latitude", using: :btree
  add_index "enderecos", ["logradouro"], name: "index_enderecos_on_logradouro", using: :btree
  add_index "enderecos", ["longitude"], name: "index_enderecos_on_longitude", using: :btree
  add_index "enderecos", ["numero"], name: "index_enderecos_on_numero", using: :btree

  create_table "escolas", force: true do |t|
    t.integer  "municipio_id"
    t.integer  "dependencia_administrativa"
    t.integer  "zona"
    t.string   "codigo"
    t.string   "nome"
    t.string   "telefone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "escolas", ["municipio_id"], name: "index_escolas_on_municipio_id", using: :btree

  create_table "estados", force: true do |t|
    t.string   "sigla"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados", ["sigla"], name: "index_estados_on_sigla", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day",       default: false
    t.string   "color"
    t.integer  "requisicao_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lotes", force: true do |t|
    t.string   "nome"
    t.integer  "numero_postos"
    t.string   "tipo"
    t.string   "cor"
    t.string   "descricao"
    t.integer  "modalidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lotes", ["modalidade_id"], name: "index_lotes_on_modalidade_id", using: :btree

  create_table "mensagens", force: true do |t|
    t.string   "texto"
    t.integer  "remetente_id"
    t.integer  "destinatario_id"
    t.string   "tipo_usuario"
    t.boolean  "lido",            default: false
    t.integer  "objeto_id"
    t.string   "objeto_type"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assunto"
  end

  add_index "mensagens", ["destinatario_id"], name: "index_mensagens_on_destinatario_id", using: :btree
  add_index "mensagens", ["remetente_id"], name: "index_mensagens_on_remetente_id", using: :btree

  create_table "modalidades", force: true do |t|
    t.string   "nome"
    t.integer  "periodo_diario",      default: 8
    t.integer  "dias_mes",            default: 22
    t.boolean  "com_motorista",       default: false
    t.boolean  "com_combustivel",     default: false
    t.boolean  "quilometragem_livre", default: false
    t.boolean  "mes_completo",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motivos", force: true do |t|
    t.string   "nome"
    t.integer  "tipo_id"
    t.boolean  "carga",               default: false
    t.boolean  "passageiro",          default: false
    t.boolean  "entrega_documento",   default: false
    t.boolean  "interior",            default: false
    t.boolean  "viagem_longa",        default: false
    t.integer  "lote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_requisicao"
    t.boolean  "urgente",             default: false
    t.boolean  "necessita_descricao", default: false
  end

  add_index "motivos", ["lote_id"], name: "index_motivos_on_lote_id", using: :btree
  add_index "motivos", ["tipo_id"], name: "index_motivos_on_tipo_id", using: :btree

  create_table "notificacoes", force: true do |t|
    t.string   "texto"
    t.string   "motivo"
    t.string   "state"
    t.integer  "origem_id"
    t.integer  "entidade_id"
    t.integer  "posto_id"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "objeto_type"
    t.integer  "objeto_id"
    t.integer  "user_id"
  end

  add_index "notificacoes", ["entidade_id"], name: "index_notificacoes_on_entidade_id", using: :btree
  add_index "notificacoes", ["objeto_id"], name: "index_notificacoes_on_objeto_id", using: :btree
  add_index "notificacoes", ["origem_id"], name: "index_notificacoes_on_origem_id", using: :btree
  add_index "notificacoes", ["posto_id"], name: "index_notificacoes_on_posto_id", using: :btree
  add_index "notificacoes", ["user_id"], name: "index_notificacoes_on_user_id", using: :btree

  create_table "patios", force: true do |t|
    t.datetime "data_entrada"
    t.integer  "veiculo_id"
    t.integer  "motorista_id"
    t.integer  "empresa_id"
    t.datetime "data_saida"
    t.string   "state"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patios", ["empresa_id"], name: "index_patios_on_empresa_id", using: :btree
  add_index "patios", ["motorista_id"], name: "index_patios_on_motorista_id", using: :btree
  add_index "patios", ["veiculo_id"], name: "index_patios_on_veiculo_id", using: :btree

  create_table "pessoas", force: true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "email"
    t.string   "matricula"
    t.integer  "cargo_id"
    t.integer  "entidade_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "departamento_id"
    t.boolean  "visivel",         default: true
  end

  add_index "pessoas", ["cargo_id"], name: "index_pessoas_on_cargo_id", using: :btree
  add_index "pessoas", ["departamento_id"], name: "index_pessoas_on_departamento_id", using: :btree
  add_index "pessoas", ["entidade_id"], name: "index_pessoas_on_entidade_id", using: :btree
  add_index "pessoas", ["user_id"], name: "index_pessoas_on_user_id", using: :btree

  create_table "pessoas_requisicoes", force: true do |t|
    t.integer "pessoa_id"
    t.integer "requisicao_id"
  end

  add_index "pessoas_requisicoes", ["pessoa_id"], name: "index_pessoas_requisicoes_on_pessoa_id", using: :btree
  add_index "pessoas_requisicoes", ["requisicao_id"], name: "index_pessoas_requisicoes_on_requisicao_id", using: :btree

  create_table "postos", force: true do |t|
    t.datetime "entrada"
    t.integer  "patio_id"
    t.integer  "veiculo_id"
    t.integer  "contrato_id"
    t.integer  "empresa_id"
    t.integer  "modalidade_id"
    t.integer  "servico_id"
    t.integer  "lote_id"
    t.datetime "saida"
    t.string   "state"
    t.integer  "position"
    t.boolean  "rotativo",          default: false
    t.string   "codigo"
    t.string   "codigo_substituto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "data_entrada"
    t.integer  "turno"
  end

  add_index "postos", ["contrato_id"], name: "index_postos_on_contrato_id", using: :btree
  add_index "postos", ["empresa_id"], name: "index_postos_on_empresa_id", using: :btree
  add_index "postos", ["lote_id"], name: "index_postos_on_lote_id", using: :btree
  add_index "postos", ["modalidade_id"], name: "index_postos_on_modalidade_id", using: :btree
  add_index "postos", ["servico_id"], name: "index_postos_on_servico_id", using: :btree
  add_index "postos", ["veiculo_id"], name: "index_postos_on_veiculo_id", using: :btree

  create_table "provisoes", force: true do |t|
    t.integer  "veiculo_id"
    t.integer  "requisicao_id"
    t.boolean  "ativo",                 default: true
    t.datetime "data_aprovisionamento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provisoes", ["requisicao_id"], name: "index_provisoes_on_requisicao_id", using: :btree
  add_index "provisoes", ["veiculo_id"], name: "index_provisoes_on_veiculo_id", using: :btree

  create_table "requisicoes", force: true do |t|
    t.string   "numero"
    t.string   "descricao"
    t.integer  "requisitante_id"
    t.date     "data_ida"
    t.date     "data_volta"
    t.string   "periodo"
    t.boolean  "periodo_longo"
    t.datetime "inicio"
    t.datetime "fim"
    t.integer  "posto_id"
    t.integer  "preferencia_id"
    t.string   "state"
    t.float    "distancia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "agenda",              default: false
    t.integer  "motivo_id"
    t.integer  "tipo_requisicao"
    t.integer  "numero_passageiros"
    t.integer  "tipo_carga"
    t.time     "hora_ida"
    t.time     "hora_volta"
    t.boolean  "pernoite"
    t.string   "motivo_cancelamento"
    t.string   "codigo_de_barras"
    t.string   "codigo"
    t.string   "numero_da_portaria"
    t.text     "kml"
  end

  add_index "requisicoes", ["posto_id"], name: "index_requisicoes_on_posto_id", using: :btree
  add_index "requisicoes", ["preferencia_id"], name: "index_requisicoes_on_preferencia_id", using: :btree
  add_index "requisicoes", ["requisitante_id"], name: "index_requisicoes_on_requisitante_id", using: :btree

  create_table "requisicoes_rotas", force: true do |t|
    t.integer "rota_id"
    t.integer "requisicao_id"
  end

  add_index "requisicoes_rotas", ["requisicao_id"], name: "index_requisicoes_rotas_on_requisicao_id", using: :btree
  add_index "requisicoes_rotas", ["rota_id"], name: "index_requisicoes_rotas_on_rota_id", using: :btree

  create_table "requisicoes_tipos", force: true do |t|
    t.integer "tipo_id"
    t.integer "requisicao_id"
  end

  add_index "requisicoes_tipos", ["requisicao_id"], name: "index_requisicoes_tipos_on_requisicao_id", using: :btree
  add_index "requisicoes_tipos", ["tipo_id"], name: "index_requisicoes_tipos_on_tipo_id", using: :btree

  create_table "rotas", force: true do |t|
    t.string   "destino"
    t.string   "roteavel_type"
    t.integer  "roteavel_id"
    t.string   "tempo_previsto"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "rota_longa"
    t.boolean  "intermunicipal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rotas", ["roteavel_id"], name: "index_rotas_on_roteavel_id", using: :btree

  create_table "servicos", force: true do |t|
    t.integer  "requisicao_id"
    t.integer  "veiculo_id"
    t.integer  "user_id"
    t.integer  "empresa_id"
    t.integer  "contrato_id"
    t.integer  "lote"
    t.datetime "saida"
    t.datetime "chegada"
    t.float    "gasto_combustivel"
    t.integer  "valor_combustivel_centavos"
    t.string   "valor_combustivel_currency", default: "BRL", null: false
    t.float    "distancia"
    t.boolean  "atendido",                   default: true
    t.boolean  "problema",                   default: false
    t.boolean  "imediato",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servicos", ["contrato_id"], name: "index_servicos_on_contrato_id", using: :btree
  add_index "servicos", ["empresa_id"], name: "index_servicos_on_empresa_id", using: :btree
  add_index "servicos", ["requisicao_id"], name: "index_servicos_on_requisicao_id", using: :btree
  add_index "servicos", ["user_id"], name: "index_servicos_on_user_id", using: :btree
  add_index "servicos", ["veiculo_id"], name: "index_servicos_on_veiculo_id", using: :btree

  create_table "tipos", force: true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome"
    t.string   "cpf"
    t.string   "authentication_token"
    t.integer  "role"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "veiculos", force: true do |t|
    t.integer  "tipo"
    t.string   "placa"
    t.string   "motor"
    t.integer  "direcao"
    t.integer  "marca"
    t.string   "modelo"
    t.integer  "capacidade_carga",       default: 0
    t.integer  "capacidade_passageiros", default: 4
    t.integer  "ano_fabricacao"
    t.integer  "ano_modelo"
    t.boolean  "itens_obrigatorios",     default: false
    t.text     "observacao"
    t.string   "qrcode"
    t.string   "codigo_de_barras"
    t.string   "gps_ip"
    t.string   "gps_imei"
    t.integer  "modalidade_id"
    t.integer  "combustivel_id"
    t.integer  "turno_id"
    t.integer  "empresa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_id"
    t.string   "codigo"
    t.integer  "contrato_id"
    t.integer  "lote_id"
    t.string   "codigo_de_barras_s"
    t.string   "codigo_s"
    t.integer  "position"
  end

  add_index "veiculos", ["combustivel_id"], name: "index_veiculos_on_combustivel_id", using: :btree
  add_index "veiculos", ["contrato_id"], name: "index_veiculos_on_contrato_id", using: :btree
  add_index "veiculos", ["empresa_id"], name: "index_veiculos_on_empresa_id", using: :btree
  add_index "veiculos", ["modalidade_id"], name: "index_veiculos_on_modalidade_id", using: :btree
  add_index "veiculos", ["tipo_id"], name: "index_veiculos_on_tipo_id", using: :btree
  add_index "veiculos", ["turno_id"], name: "index_veiculos_on_turno_id", using: :btree

end
