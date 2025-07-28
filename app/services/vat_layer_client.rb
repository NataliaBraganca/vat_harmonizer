require "net/http"
require "uri"
require "json"

class VatLayerClient
  BASE_URL = "https://apilayer.net/api"
  ACCESS_KEY = ENV["VATLAYER_API_KEY"]

  def self.fetch_rates(country_code)
    raise "VATLAYER_API_KEY not set!" if ACCESS_KEY.nil? || ACCESS_KEY.empty?

    url = URI("#{BASE_URL}/rate?access_key=#{ACCESS_KEY}&country_code=#{country_code}")
    puts "URL: #{url}"

    response = Net::HTTP.get(url)
    json = JSON.parse(response)
    puts "Response: #{json.inspect}"

    if json["success"]
      {
        country_name: json["country_name"],
        country_code: json["country_code"],
        standard_rate: json["standard_rate"],
        reduced_rates: json["reduced_rates"]
      }
    else
      raise "Vatlayer error: #{json["error"]}"
    end
  end
end
