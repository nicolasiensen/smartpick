require 'spec_helper'

describe Compare do
  it { should have_and_belong_to_many :models }

  describe "#presence_of_models" do
    context "when it have no models" do
      subject {Compare.new}
      it { should_not be_valid }
    end
    context "when it have at least one model" do
      subject {Compare.new models: [Model.make!]}
      it { should be_valid }
    end
  end
end
