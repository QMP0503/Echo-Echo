class RenameEchoesToEchos < ActiveRecord::Migration[8.0]
  def change
    rename_table :echoes, :echos
  end
end
