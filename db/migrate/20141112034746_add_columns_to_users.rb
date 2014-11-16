class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_token, :string
    add_column :users, :remote_id, :integer
  end
end
