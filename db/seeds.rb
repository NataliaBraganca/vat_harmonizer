# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
require 'csv'

csv_path = Rails.root.join('db', 'seeds', 'eu_vat_data.csv')

puts "🌍 Importando dados de países da União Europeia..."

CSV.foreach(csv_path, headers: true) do |row|
  EuCountry.create!(
    name: row['name'],
    code: row['code'],
    standard_vat_rate: row['standard_vat_rate'],
    reduced_vat_rates: row['reduced_vat_rates'].present? ? JSON.parse(row['reduced_vat_rates']) : {},
    oss_threshold: row['oss_threshold'],
    reverse_charge_note: row['reverse_charge_note'],
    requires_vat_registration: row['requires_vat_registration'] == 'true',
    vat_authority_url: row['vat_authority_url']
  )
end

puts "✅ Dados importados com sucesso!"
