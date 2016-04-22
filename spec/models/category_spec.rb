require 'spec_helper'

describe Category do
  it { should have_many(:posts).order('created_at DESC')}
end