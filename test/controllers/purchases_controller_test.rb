require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_url
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post purchases_url, params: { purchase: { APPLICATION_DATE_FOR_REMOVAL_OF_GOODS: @purchase.APPLICATION_DATE_FOR_REMOVAL_OF_GOODS, APPLICATION_NO_FOR_REMOVAL_OF_GOODS: @purchase.APPLICATION_NO_FOR_REMOVAL_OF_GOODS, BUYER_ADDRESS: @purchase.BUYER_ADDRESS, BUYER_CIN: @purchase.BUYER_CIN, BUYER_GSTIN_UIN: @purchase.BUYER_GSTIN_UIN, BUYER_NAME: @purchase.BUYER_NAME, BUYER_STATE: @purchase.BUYER_STATE, BUYER_STATE_CODE: @purchase.BUYER_STATE_CODE, CIN: @purchase.CIN, CONSIGNEE_ADDRESS: @purchase.CONSIGNEE_ADDRESS, CONSIGNEE_CIN: @purchase.CONSIGNEE_CIN, CONSIGNEE_GSTIN_UIN: @purchase.CONSIGNEE_GSTIN_UIN, CONSIGNEE_NAME: @purchase.CONSIGNEE_NAME, CONSIGNEE_STATE: @purchase.CONSIGNEE_STATE, CONSIGNEE_STATE_CODE: @purchase.CONSIGNEE_STATE_CODE, DATE_OF_SUPPLY: @purchase.DATE_OF_SUPPLY, EMAIL_ID: @purchase.EMAIL_ID, FAX: @purchase.FAX, GSTIN_UIN: @purchase.GSTIN_UIN, INVOICE_DATE: @purchase.INVOICE_DATE, INVOICE_NO: @purchase.INVOICE_NO, PAN: @purchase.PAN, PLACE_OF_SUPPLY: @purchase.PLACE_OF_SUPPLY, REVERSE_CHARGE: @purchase.REVERSE_CHARGE, STATE: @purchase.STATE, STATE_CODE: @purchase.STATE_CODE, TELEPHONE_NO: @purchase.TELEPHONE_NO, TRANSPORTATION_MODE: @purchase.TRANSPORTATION_MODE, VEHICLE_NO: @purchase.VEHICLE_NO } }
    end

    assert_redirected_to purchase_url(Purchase.last)
  end

  test "should show purchase" do
    get purchase_url(@purchase)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_url(@purchase)
    assert_response :success
  end

  test "should update purchase" do
    patch purchase_url(@purchase), params: { purchase: { APPLICATION_DATE_FOR_REMOVAL_OF_GOODS: @purchase.APPLICATION_DATE_FOR_REMOVAL_OF_GOODS, APPLICATION_NO_FOR_REMOVAL_OF_GOODS: @purchase.APPLICATION_NO_FOR_REMOVAL_OF_GOODS, BUYER_ADDRESS: @purchase.BUYER_ADDRESS, BUYER_CIN: @purchase.BUYER_CIN, BUYER_GSTIN_UIN: @purchase.BUYER_GSTIN_UIN, BUYER_NAME: @purchase.BUYER_NAME, BUYER_STATE: @purchase.BUYER_STATE, BUYER_STATE_CODE: @purchase.BUYER_STATE_CODE, CIN: @purchase.CIN, CONSIGNEE_ADDRESS: @purchase.CONSIGNEE_ADDRESS, CONSIGNEE_CIN: @purchase.CONSIGNEE_CIN, CONSIGNEE_GSTIN_UIN: @purchase.CONSIGNEE_GSTIN_UIN, CONSIGNEE_NAME: @purchase.CONSIGNEE_NAME, CONSIGNEE_STATE: @purchase.CONSIGNEE_STATE, CONSIGNEE_STATE_CODE: @purchase.CONSIGNEE_STATE_CODE, DATE_OF_SUPPLY: @purchase.DATE_OF_SUPPLY, EMAIL_ID: @purchase.EMAIL_ID, FAX: @purchase.FAX, GSTIN_UIN: @purchase.GSTIN_UIN, INVOICE_DATE: @purchase.INVOICE_DATE, INVOICE_NO: @purchase.INVOICE_NO, PAN: @purchase.PAN, PLACE_OF_SUPPLY: @purchase.PLACE_OF_SUPPLY, REVERSE_CHARGE: @purchase.REVERSE_CHARGE, STATE: @purchase.STATE, STATE_CODE: @purchase.STATE_CODE, TELEPHONE_NO: @purchase.TELEPHONE_NO, TRANSPORTATION_MODE: @purchase.TRANSPORTATION_MODE, VEHICLE_NO: @purchase.VEHICLE_NO } }
    assert_redirected_to purchase_url(@purchase)
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete purchase_url(@purchase)
    end

    assert_redirected_to purchases_url
  end
end
