class CreateSocialPosts < ActiveRecord::Migration
  def change
    create_table :social_posts do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false, limit: 5
      t.integer :day_subject_id, null: false
      t.string  :service_name, null: false

      t.timestamps null: false
    end
  end
end
