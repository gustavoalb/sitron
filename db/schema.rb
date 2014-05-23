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

ActiveRecord::Schema.define(version: 20140523172711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bairros", force: true do |t|
    t.string   "nome"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bairros", ["nome"], name: "index_bairros_on_nome", using: :btree

  create_table "cidades", force: true do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.boolean  "capital",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cidades", ["nome"], name: "index_cidades_on_nome", using: :btree

  create_table "combustiveis", force: true do |t|
    t.string   "nome"
    t.decimal  "valor",      precision: 18, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuracoes", force: true do |t|
    t.string   "skin"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", force: true do |t|
    t.string   "nome"
    t.string   "cnpj"
    t.integer  "endereco_id"
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enderecos", force: true do |t|
    t.string   "logradouro"
    t.string   "numero"
    t.string   "complemento"
    t.string   "cep"
    t.integer  "bairro_id"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "enderecavel_id"
    t.string   "enderecavel_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enderecos", ["latitude"], name: "index_enderecos_on_latitude", using: :btree
  add_index "enderecos", ["logradouro"], name: "index_enderecos_on_logradouro", using: :btree
  add_index "enderecos", ["longitude"], name: "index_enderecos_on_longitude", using: :btree
  add_index "enderecos", ["numero"], name: "index_enderecos_on_numero", using: :btree

  create_table "estados", force: true do |t|
    t.string   "sigla"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados", ["sigla"], name: "index_estados_on_sigla", unique: true, using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
