class AddOmniauthDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :image, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
