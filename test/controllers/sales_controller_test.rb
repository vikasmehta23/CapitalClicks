require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get sales_url
    assert_response :success
  end

  test "should get new" do
    get new_sale_url
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count') do
      post sales_url, params: { sale: { APPLICATION_DATE_FOR_REMOVAL_OF_GOODS: @sale.APPLICATION_DATE_FOR_REMOVAL_OF_GOODS, APPLICATION_NO_FOR_REMOVAL_OF_GOODS: @sale.APPLICATION_NO_FOR_REMOVAL_OF_GOODS, BUYER_ADDRESS: @sale.BUYER_ADDRESS, BUYER_CIN: @sale.BUYER_CIN, BUYER_GSTIN_UIN: @sale.BUYER_GSTIN_UIN, BUYER_NAME: @sale.BUYER_NAME, BUYER_STATE: @sale.BUYER_STATE, BUYER_STATE_CODE: @sale.BUYER_STATE_CODE, CIN: @sale.CIN, CONSIGNEE_ADDRESS: @sale.CONSIGNEE_ADDRESS, CONSIGNEE_CIN: @sale.CONSIGNEE_CIN, CONSIGNEE_GSTIN_UIN: @sale.CONSIGNEE_GSTIN_UIN, CONSIGNEE_NAME: @sale.CONSIGNEE_NAME, CONSIGNEE_STATE: @sale.CONSIGNEE_STATE, CONSIGNEE_STATE_CODE: @sale.CONSIGNEE_STATE_CODE, DATE_OF_SUPPLY: @sale.DATE_OF_SUPPLY, EMAIL_ID: @sale.EMAIL_ID, FAX: @sale.FAX, GSTIN_UIN: @sale.GSTIN_UIN, INVOICE_DATE: @sale.INVOICE_DATE, INVOICE_NO: @sale.INVOICE_NO, PAN: @sale.PAN, PLACE_OF_SUPPLY: @sale.PLACE_OF_SUPPLY, REVERSE_CHARGE: @sale.REVERSE_CHARGE, STATE: @sale.STATE, STATE_CODE: @sale.STATE_CODE, TELEPHONE_NO: @sale.TELEPHONE_NO, TRANSPORTATION_MODE: @sale.TRANSPORTATION_MODE, VEHICLE_NO: @sale.VEHICLE_NO } }
    end

    assert_redirected_to sale_url(Sale.last)
  end

  test "should show sale" do
    get sale_url(@sale)
    assert_response :success
  end

  test "should get edit" do
    get edit_sale_url(@sale)
    assert_response :success
  end

  test "should update sale" do
    patch sale_url(@sale), params: { sale: { APPLICATION_DATE_FOR_REMOVAL_OF_GOODS: @sale.APPLICATION_DATE_FOR_REMOVAL_OF_GOODS, APPLICATION_NO_FOR_REMOVAL_OF_GOODS: @sale.APPLICATION_NO_FOR_REMOVAL_OF_GOODS, BUYER_ADDRESS: @sale.BUYER_ADDRESS, BUYER_CIN: @sale.BUYER_CIN, BUYER_GSTIN_UIN: @sale.BUYER_GSTIN_UIN, BUYER_NAME: @sale.BUYER_NAME, BUYER_STATE: @sale.BUYER_STATE, BUYER_STATE_CODE: @sale.BUYER_STATE_CODE, CIN: @sale.CIN, CONSIGNEE_ADDRESS: @sale.CONSIGNEE_ADDRESS, CONSIGNEE_CIN: @sale.CONSIGNEE_CIN, CONSIGNEE_GSTIN_UIN: @sale.CONSIGNEE_GSTIN_UIN, CONSIGNEE_NAME: @sale.CONSIGNEE_NAME, CONSIGNEE_STATE: @sale.CONSIGNEE_STATE, CONSIGNEE_STATE_CODE: @sale.CONSIGNEE_STATE_CODE, DATE_OF_SUPPLY: @sale.DATE_OF_SUPPLY, EMAIL_ID: @sale.EMAIL_ID, FAX: @sale.FAX, GSTIN_UIN: @sale.GSTIN_UIN, INVOICE_DATE: @sale.INVOICE_DATE, INVOICE_NO: @sale.INVOICE_NO, PAN: @sale.PAN, PLACE_OF_SUPPLY: @sale.PLACE_OF_SUPPLY, REVERSE_CHARGE: @sale.REVERSE_CHARGE, STATE: @sale.STATE, STATE_CODE: @sale.STATE_CODE, TELEPHONE_NO: @sale.TELEPHONE_NO, TRANSPORTATION_MODE: @sale.TRANSPORTATION_MODE, VEHICLE_NO: @sale.VEHICLE_NO } }
    assert_redirected_to sale_url(@sale)
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete sale_url(@sale)
    end

    assert_redirected_to sales_url
  end
end
