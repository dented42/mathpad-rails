require 'rails_helper'

RSpec.describe "scratchpads/index", type: :view do
  before(:each) do
    assign(:scratchpads, [
      Scratchpad.create!(
        :title => "Title",
        :description => "MyText"
      ),
      Scratchpad.create!(
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of scratchpads" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
