class CreateInboxes < ActiveRecord::Migration[7.0]
  def change
    create_table :inboxes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
