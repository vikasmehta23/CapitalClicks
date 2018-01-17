class AddGstandremarkToExportsales < ActiveRecord::Migration[5.1]
  def change
    add_column :exportsales, :gstper, :string
    add_column :exportsales, :remark, :string
  end
end
