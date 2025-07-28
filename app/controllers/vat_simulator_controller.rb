class VatSimulatorController < ApplicationController
  def index
    @countries = EuCountry.all.order(:name)
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
    render :calculate
  end
end
