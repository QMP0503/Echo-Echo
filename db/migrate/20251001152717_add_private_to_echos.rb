class AddPrivateToEchos < ActiveRecord::Migration[8.0]
  def change
    add_column :echos, :private, :boolean, default: false, null: false
  end
end
