require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password}
  it { should have_many(:comments)}
  it { should have_many(:posts).order('created_at DESC')}
  it { should have_many(:recipes).order('created_at DESC')}
  it { should have_attached_file(:avatar)}
  it { should validate_attachment_content_type(:avatar).
              allowing('image/\Aimage\/.*\Z/').
              rejecting('text/\Atext\/.*\Z/')}
  describe '#admin?' do
    it "returns true if user's role equal admin" do
      user = Fabricate(:user, role: 'admin')
      user.admin?.should be_truthy
    end

    it "returns false if user's role equal admin" do
      user = Fabricate(:user, role: nil)
      user.admin?.should be_falsey
    end
  end
end