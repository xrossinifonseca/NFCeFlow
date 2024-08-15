# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_15_004416) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "issuers", force: :cascade do |t|
    t.string "cnpj", limit: 14, null: false
    t.string "nome", null: false
    t.string "nome_fantasia", null: false
    t.string "logradouro"
    t.string "numero", limit: 10
    t.string "municipio"
    t.integer "codigo_municipio"
    t.string "bairro"
    t.string "pais"
    t.string "uf", limit: 2
    t.string "cep", limit: 8
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_issuers_on_cnpj", unique: true
  end

  create_table "nfce_products", force: :cascade do |t|
    t.integer "nfce_id", null: false
    t.integer "product_id", null: false
    t.decimal "valor_unitario", precision: 10, scale: 2, null: false
    t.string "unidade_comercializada", null: false
    t.decimal "quantidade_comercializada", precision: 10, scale: 2, null: false
    t.decimal "valor_icms", precision: 10, scale: 2
    t.decimal "valor_ipi", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total", precision: 10, scale: 2
    t.index ["nfce_id"], name: "index_nfce_products_on_nfce_id"
    t.index ["product_id"], name: "index_nfce_products_on_product_id"
  end

  create_table "nfces", force: :cascade do |t|
    t.string "serie", null: false
    t.string "numero_nota", null: false
    t.date "data_emissao", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total_desconto", precision: 10, scale: 2
    t.decimal "valor_total_produtos", precision: 10, scale: 2
    t.decimal "valor_total", precision: 10, scale: 2
    t.integer "customer_id"
    t.integer "issuer_id"
    t.integer "recipient_id"
    t.index ["numero_nota"], name: "index_nfces_on_numero_nota", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "nome", null: false
    t.string "ncm"
    t.string "cfop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipients", force: :cascade do |t|
    t.string "cnpj", limit: 14, null: false
    t.string "nome", null: false
    t.string "logradouro"
    t.string "numero", limit: 10
    t.string "municipio"
    t.integer "codigo_municipio"
    t.string "bairro"
    t.string "pais"
    t.string "uf", limit: 2
    t.string "cep", limit: 8
    t.string "telefone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnpj"], name: "index_recipients_on_cnpj", unique: true
  end

  create_table "taxes", force: :cascade do |t|
    t.bigint "nfce_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total_pis", precision: 10, scale: 2
    t.decimal "valor_total_cofins", precision: 10, scale: 2
    t.decimal "valor_icms", precision: 10, scale: 2
    t.decimal "valor_total_ipi", precision: 10, scale: 2
    t.decimal "valor_tributo", precision: 10, scale: 2
    t.index ["nfce_id"], name: "index_taxes_on_nfce_id"
  end

  add_foreign_key "nfce_products", "nfces"
  add_foreign_key "nfce_products", "products"
  add_foreign_key "nfces", "customers"
  add_foreign_key "nfces", "issuers"
  add_foreign_key "nfces", "recipients"
  add_foreign_key "taxes", "nfces"
end
