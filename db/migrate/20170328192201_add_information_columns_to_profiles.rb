class AddInformationColumnsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :location, :string
    add_column :profiles, :website,  :string
  end
end
