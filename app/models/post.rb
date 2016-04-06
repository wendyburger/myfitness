class Post < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :category
  belongs_to :user

  has_attached_file :image

  validates_attachment_content_type :image, 
    content_type:  /^image\/(png|gif|jpeg|jpg)/,
    message: "Only images allowed"

  auto_html_for :content do
    html_escape
    image
    youtube(width:'100%', height: 250)
    link target: '_blank', rel: 'nofollow'
    simple_format
  end

end