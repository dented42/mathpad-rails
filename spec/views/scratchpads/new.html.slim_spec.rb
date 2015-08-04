require 'rails_helper'

RSpec.describe "scratchpads/new", type: :view do
  before(:each) do
    assign(:scratchpad, Scratchpad.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new scratchpad form" do
    render

    assert_select "form[action=?][method=?]", scratchpads_path, "post" do

      assert_select "input#scratchpad_title[name=?]", "scratchpad[title]"

      assert_select "textarea#scratchpad_description[name=?]", "scratchpad[description]"
    end
  end
end
