class AddLandlineToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :landline, :string
  end
end
