require 'spec_helper'

describe Car do
  it { should validate_presence_of :name }
  it { should validate_presence_of :brand_id }
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of :uid }
  it { should belong_to :brand }
  it { should have_many :models }
end
