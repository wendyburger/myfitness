class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  
  has_secure_password validations: false
  has_many :posts
  has_many :comments
  has_many :recipes

  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 50

  def admin?
    self.role == 'admin'
  end
end