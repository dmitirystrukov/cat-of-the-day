class CreateDaySubjects < ActiveRecord::Migration
  def change
    create_table :day_subjects do |t|
      t.string :name
      t.string :description
      t.string :photo

      t.timestamps null: false
    end
  end
end
