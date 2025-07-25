class CreateEuCountries < ActiveRecord::Migration[7.2]
  def change
    create_table :eu_countries do |t|
      t.string :name
      t.string :code
      t.decimal :standard_vat_rate
      t.jsonb :reduced_vat_rates
      t.decimal :oss_threshold
      t.text :reverse_charge_note
      t.boolean :requires_vat_registration
      t.string :vat_authority_url

      t.timestamps
    end
  end
end
