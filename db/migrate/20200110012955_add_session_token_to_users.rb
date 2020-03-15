class AddSessionTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :session_token, unique: true
  end
end
