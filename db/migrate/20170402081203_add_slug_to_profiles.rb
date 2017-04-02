class AddSlugToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :slug,     :string, uniq: true
    add_column :profiles, :nickname, :string, uniq: true
  end
end
