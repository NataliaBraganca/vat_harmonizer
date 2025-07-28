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
puts "🌍 Importing EU VAT data using the Vatlayer API..."

puts "🌍 Importing EU VAT data using the Vatlayer API..."

["DE", "FR", "IT", "BE", "NL"].each do |code|
  begin
    data = VatLayerClient.fetch_rates(code)

    EuCountry.create!(
      name: data[:country_name],
      code: data[:country_code],
      standard_vat_rate: data[:standard_rate],
      reduced_vat_rates: data[:reduced_rates],
      oss_threshold: 10_000,
      reverse_charge_note: "Reverse charge applies for B2B transactions with valid VAT ID",
      requires_vat_registration: false,
      vat_authority_url: "https://europa.eu/youreurope/business/taxation/vat/index_en.htm"
    )
    puts "✅ Imported: #{data[:country_name]} (#{code})"
  rescue => e
    puts "⚠️ Error importing #{code}: #{e.message}"
  end
end

