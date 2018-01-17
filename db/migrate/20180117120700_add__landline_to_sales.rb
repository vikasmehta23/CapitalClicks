class AddLandlineToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :landline, :string
  end
end
