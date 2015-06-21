require 'rails_helper'

RSpec.describe "scratchpads/index", type: :view do
  before(:each) do
    assign(:scratchpads, [
      Fabricate(:scratchpad),
      Fabricate(:scratchpad)
    ])
  end

  it "renders a list of scratchpads" do
    render
    assert_select "table>tbody>tr" do | rows |
      assert_select rows[0], "td", :text => Scratchpad.all[0].title
      assert_select rows[0], "td", :text => Scratchpad.all[0].user.username
      
      assert_select rows[1], "td", :text => Scratchpad.all[1].title
      assert_select rows[1], "td", :text => Scratchpad.all[1].user.username
    end
  end
end
