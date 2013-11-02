require 'spec_helper'

describe Model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :car_id }
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of :uid }
end
