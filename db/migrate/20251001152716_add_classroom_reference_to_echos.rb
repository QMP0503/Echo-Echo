class AddClassroomReferenceToEchos < ActiveRecord::Migration[8.0]
  def change
    add_reference :echos, :classroom, null: false, foreign_key: true
  end
end
