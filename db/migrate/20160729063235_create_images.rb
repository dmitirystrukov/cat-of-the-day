class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :object_id,   null: false
      t.string  :object_type, null: false
      t.string  :url,         null: false

      t.timestamps null: false
    end
  end
end
