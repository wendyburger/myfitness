class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :category

  has_attached_file :image

  validates_attachment_content_type :image, 
    content_type:  /^image\/(png|gif|jpeg|jpg)/,
    message: "Only images allowed"

end