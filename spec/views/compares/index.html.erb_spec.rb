require 'spec_helper'

describe "compares/index" do
  before(:each) do
    assign(:compares, [
      stub_model(Compare),
      stub_model(Compare)
    ])
  end

  it "renders a list of compares" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
