require 'spec_helper'

describe Brand do
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of :uid }
end
