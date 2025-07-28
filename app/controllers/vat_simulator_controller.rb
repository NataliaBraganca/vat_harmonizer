class VatSimulatorController < ApplicationController
  def index
    # Lista todos os países disponíveis
    @countries = EuCountry.order(:name)

    raw_categories = @countries.map do |country|
      rates = country.reduced_vat_rates
      rates = JSON.parse(rates) if rates.is_a?(String)
      rates&.keys || []
    end

    @categories = raw_categories.flatten.uniq.sort
  end



  def calculate
    @origin_country = EuCountry.find_by(code: params[:origin_country])
    @destination_country = EuCountry.find_by(code: params[:destination_country])
    @category = params[:product_category]
    @sale_value = params[:sale_value].to_f

    if @origin_country.nil? || @destination_country.nil?
      flash[:alert] = "One or both countries are not available in the database."
      redirect_to vat_simulator_path and return
    end

    reduced_rates = JSON.parse(@destination_country.reduced_vat_rates || "{}")
    matched_key = reduced_rates.keys.find { |key| key.downcase.include?(@category.downcase) }

    vat_rate = matched_key ? reduced_rates[matched_key] : @destination_country.standard_vat_rate

    @vat_rate = vat_rate
    @vat_amount = @sale_value * (@vat_rate / 100.0)
    @total_amount = @sale_value + @vat_amount

    render :calculate
  end
end
