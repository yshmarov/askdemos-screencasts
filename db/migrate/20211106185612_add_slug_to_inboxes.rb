class AddSlugToInboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :inboxes, :slug, :string
    add_index :inboxes, :slug, unique: true
  end
end
