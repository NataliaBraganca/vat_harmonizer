require "test_helper"

class VatSimulatorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vat_simulator_index_url
    assert_response :success
  end

  test "should get calculate" do
    get vat_simulator_calculate_url
    assert_response :success
  end
end
