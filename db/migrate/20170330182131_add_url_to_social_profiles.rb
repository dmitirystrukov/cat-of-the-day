class AddUrlToSocialProfiles < ActiveRecord::Migration
  def change
    add_column :social_profiles, :url, :string
  end
end
