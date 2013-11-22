require 'spec_helper'

describe "compares/edit" do
  before(:each) do
    @compare = assign(:compare, stub_model(Compare))
  end

  it "renders the edit compare form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", compare_path(@compare), "post" do
    end
  end
end
