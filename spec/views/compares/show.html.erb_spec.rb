require 'spec_helper'

describe "compares/show" do
  before(:each) do
    @compare = assign(:compare, stub_model(Compare))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
