class AddCinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cin, :string
  end
end
