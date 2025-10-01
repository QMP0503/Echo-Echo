class AddClassroomReferenceToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :classroom, null: false, foreign_key: true
  end
end
