class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :object_id, null: false
      t.integer :object_type, null: false

      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size

      t.timestamp :image_updated_at
    end
  end
end
