class CreateExports < ActiveRecord::Migration[5.1]
  def change
    create_table :exports do |t|
      t.references :purchase, foreign_key: true
      t.string :NAME_OF_GOODS_SERVICES
      t.string :HSNC_ACS
      t.string :UQM
      t.string :QTY
      t.string :RATE_P_U
      t.string :AMOUNT
      t.string :LESS_DISCOUNT_ABATEMENT
      t.string :TAXABLE_AMOUNT
      t.string :CGST_RATE_OF_TAX
      t.string :CGST_AMT
      t.string :SGST_RATE_OF_TAX
      t.string :SGST_AMT
      t.string :IGST_RATE_OF_TAX
      t.string :IGST_AMT
      t.string :TOTAL_AMOUNT

      t.timestamps
    end
  end
end
