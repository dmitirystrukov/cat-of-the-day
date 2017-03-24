class CreateSocialPosts < ActiveRecord::Migration
  def change
    create_table :social_posts do |t|
      t.integer :user_id, null: false
      t.string  :post_id, null: false
      t.string  :url, null: false
      t.string  :message
      t.integer :day_subject_image_id, null: false
      t.integer :day_subject_id, null: false
      t.string  :service_name, null: false

      t.timestamps null: false
    end
  end
end
