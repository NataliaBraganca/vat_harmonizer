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

ActiveRecord::Schema[7.2].define(version: 2025_07_25_132748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eu_countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.decimal "standard_vat_rate"
    t.jsonb "reduced_vat_rates"
    t.decimal "oss_threshold"
    t.text "reverse_charge_note"
    t.boolean "requires_vat_registration"
    t.string "vat_authority_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
