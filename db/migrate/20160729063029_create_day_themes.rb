class CreateDayThemes < ActiveRecord::Migration
  def change
    create_table :day_themes do |t|
      t.integer :user_id,     null: false
      t.string  :title,       null: false
      t.string  :description, null: false

      t.timestamps null: false
    end
  end
end