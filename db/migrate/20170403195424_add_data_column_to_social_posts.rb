class AddDataColumnToSocialPosts < ActiveRecord::Migration
  def change
    add_column :social_posts, :data, :json
  end
end
