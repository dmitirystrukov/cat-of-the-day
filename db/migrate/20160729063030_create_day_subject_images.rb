class CreateDaySubjectImages < ActiveRecord::Migration
  def change
    create_table :day_subject_images do |t|
      t.integer :day_subject_id, null: false
      t.string  :url,            null: false

      t.timestamps null: false
    end
  end
end
