class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :company, :string
    add_column :users, :address, :string
    add_column :users, :gst, :string
    add_column :users, :phone, :string
    add_column :users, :bankname, :string
    add_column :users, :branchcode, :string
    add_column :users, :accountnumber, :string
    add_column :users, :ifsccode, :string
    add_column :users, :pan, :string
  end
end
