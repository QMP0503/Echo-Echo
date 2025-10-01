class RenameQuotesToEchoes < ActiveRecord::Migration[8.0]
  def change
    rename_table :quotes, :echoes
  end
end
