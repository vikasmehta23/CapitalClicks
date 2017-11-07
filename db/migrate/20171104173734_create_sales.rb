class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :GSTIN_UIN
      t.string :EMAIL_ID
      t.string :CIN
      t.string :TELEPHONE_NO
      t.string :PAN
      t.string :FAX
      t.string :REVERSE_CHARGE
      t.string :TRANSPORTATION_MODE
      t.string :INVOICE_NO
      t.string :VEHICLE_NO
      t.datetime :INVOICE_DATE
      t.datetime :DATE_OF_SUPPLY
      t.string :STATE
      t.string :PLACE_OF_SUPPLY
      t.string :STATE_CODE
      t.string :BUYER_NAME
      t.string :BUYER_ADDRESS
      t.string :BUYER_GSTIN_UIN
      t.string :BUYER_CIN
      t.string :BUYER_STATE
      t.string :BUYER_STATE_CODE
      t.string :CONSIGNEE_NAME
      t.string :CONSIGNEE_ADDRESS
      t.string :CONSIGNEE_GSTIN_UIN
      t.string :CONSIGNEE_CIN
      t.string :CONSIGNEE_STATE
      t.string :CONSIGNEE_STATE_CODE
      t.string :APPLICATION_NO_FOR_REMOVAL_OF_GOODS
      t.datetime :APPLICATION_DATE_FOR_REMOVAL_OF_GOODS

      t.timestamps
    end
  end
end
