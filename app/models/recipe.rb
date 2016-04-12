class Recipe < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_attached_file :image


  validates_attachment_content_type :image, 
    content_type:  /^image\/(png|gif|jpeg|jpg)/,
    message: "Only images allowed"
end