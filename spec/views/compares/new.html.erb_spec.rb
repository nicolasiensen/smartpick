require 'spec_helper'

describe "compares/new" do
  before(:each) do
    assign(:compare, stub_model(Compare).as_new_record)
  end

  it "renders new compare form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", compares_path, "post" do
    end
  end
end
