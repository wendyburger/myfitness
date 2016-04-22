require 'spec_helper'

describe Recipe do
  it { should belong_to(:creator) }
  it { should validate_presence_of(:dishname)}
  it { should validate_presence_of(:protocol)}
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image).
              allowing('image/png','image/gif','image/jpeg', 'image/jpg').
              rejecting('text/plain', 'text/xml')}
end