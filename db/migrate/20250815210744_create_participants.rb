class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :participants, [:course_id, :email], unique: true
  end
end