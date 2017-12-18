class AddCommentToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :comment, :string
  end
end
