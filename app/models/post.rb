class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :category

  has_attached_file :image
end