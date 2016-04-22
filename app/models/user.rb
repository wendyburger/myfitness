class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  
  has_secure_password validations: false
  has_many :posts, -> { order 'created_at DESC' }
  has_many :comments
  has_many :recipes, -> { order 'created_at DESC' }

  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 50

  has_attached_file :avatar, 
                    styles: {
                    large: "500x500>",
                    medium: "300x300>",
                    small: "100x100>",
                    thumb: "50x50>" 
                    }

  validates_attachment_content_type :avatar, 
                                    content_type: /\Aimage\/.*\Z/

  def admin?
    self.role == 'admin'
  end
end