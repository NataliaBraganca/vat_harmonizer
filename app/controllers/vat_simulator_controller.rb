class VatSimulatorController < ApplicationController
  def index
    @countries = EuCountry.all.order(:name)
  end

  def calculate
    @countries = EuCountry.all.order(:name)

    origin_code = params[:origin_country]
    destination_code = params[:destination_country]
    category = params[:product_category]
    sale_value = params[:sale_value].to_f

    @destination_country = EuCountry.find_by(code: destination_code)

    if @destination_country.nil?
      flash[:alert] = "País de destino inválido"
      return redirect_to root_path
    end

    # Lógica para determinar a alíquota
    reduced_rates = @destination_country.reduced_vat_rates || {}
    @vat_rate = reduced_rates[category] || @destination_country.standard_vat_rate

    @vat_amount = (sale_value * @vat_rate) / 100.0
    @total_amount = sale_value + @vat_amount

    render :calculate
  end
end
