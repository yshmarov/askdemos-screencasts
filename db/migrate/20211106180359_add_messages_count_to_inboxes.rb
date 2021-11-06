class AddMessagesCountToInboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :inboxes, :messages_count, :integer, null: false, default: 0
  end
end
