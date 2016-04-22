require 'spec_helper'

describe Comment do
  it { should belong_to(:creator)}
  it { should belong_to(:post)}
  it { validate_presence_of(:body)}
end