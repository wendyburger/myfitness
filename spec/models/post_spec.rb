require 'spec_helper'

describe Post do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should belong_to(:category)}
  it { should belong_to(:user)}
  it { should have_many(:comments)}
  it { should have_attached_file(:image)}
  it { should validate_attachment_content_type(:image).
              allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg').
              rejecting('text/plain', 'text/xml')}
end