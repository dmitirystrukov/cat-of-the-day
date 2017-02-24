class AddStatusColumnToSocialPosts < ActiveRecord::Migration
  def change
    add_column :social_posts, :status, :string
  end
end
