require 'spec_helper'

describe Reference do
  it { should validate_presence_of :price }
  it { should validate_presence_of :model_id }
  it { should validate_presence_of :date }
end
