class AddThemeColorToInboxes < ActiveRecord::Migration[7.0]
  def change
    add_column :inboxes, :theme_color, :string, null: false, default: "#f5af00"
  end
end
