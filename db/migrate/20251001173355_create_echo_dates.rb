class CreateEchoDates < ActiveRecord::Migration[8.0]
  def change
    create_table :echo_dates do |t|
      t.references :echo, null: false, foreign_key: true
      # Adding null: false constraint on date
      t.date :date, null: false

      t.timestamps
    end

    # Adding uniqueness constraint for the couple date and echo_id
    add_index :echo_dates, [ :date, :echo_id ], unique: true
    # Adding index to the date field for performance reasons
    add_index :echo_dates, :date
  end
end
