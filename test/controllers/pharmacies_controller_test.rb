require 'test_helper'

class PharmaciesControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get pharmacies_dashboard_url
    assert_response :success
  end

  test "should get edit" do
    get pharmacies_edit_url
    assert_response :success
  end

  test "should get update" do
    get pharmacies_update_url
    assert_response :success
  end

end
