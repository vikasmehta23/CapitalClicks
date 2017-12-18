class AddCommentToSales < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :comment, :string
  end
end
