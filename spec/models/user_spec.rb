require 'rails_helper'

describe User do
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }
end
