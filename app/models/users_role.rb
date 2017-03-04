class UsersRole < ActiveRecord::Base
  has_one :role, primary_key: :role_id, foreign_key: :id
end
