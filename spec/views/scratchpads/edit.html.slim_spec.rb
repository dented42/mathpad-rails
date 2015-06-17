require 'rails_helper'

RSpec.describe "scratchpads/edit", type: :view do
  before(:each) do
    @scratchpad = assign(:scratchpad, Scratchpad.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit scratchpad form" do
    render

    assert_select "form[action=?][method=?]", scratchpad_path(@scratchpad), "post" do

      assert_select "input#scratchpad_title[name=?]", "scratchpad[title]"

      assert_select "textarea#scratchpad_description[name=?]", "scratchpad[description]"
    end
  end
end
