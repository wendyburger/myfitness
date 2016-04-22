class Category < ActiveRecord::Base
  has_many :posts, -> { order 'created_at DESC' }
end