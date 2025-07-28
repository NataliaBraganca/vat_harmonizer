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

eu_countries = [ "DE", "FR", "IT", "BE", "NL" ] # Germany, France, Italy, Belgium, Netherlands

eu_countries.each do |code|
  begin
    rates = VatLayerClient.fetch_rates(code)

    EuCountry.find_or_create_by!(code: code) do |country|
      country.name = rates[:country_name]
      country.standard_vat_rate = rates[:standard_rate]
      country.reduced_vat_rates = rates[:reduced_rates].to_json
      country.oss_threshold = 10_000
      country.reverse_charge_note = "Reverse charge applies for B2B transactions with valid VAT ID"
      country.requires_vat_registration = false
      country.vat_authority_url = "https://europa.eu/youreurope/business/taxation/vat/index_en.htm"
    end

    puts "✅ Imported: #{rates[:country_name]} (#{code})"
  rescue => e
    puts "⚠️ Error importing #{code}: #{e.message}"
  end
end
