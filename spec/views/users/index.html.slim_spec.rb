require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      Fabricate(:user),
      Fabricate(:user)
    ])
  end

  it "renders a list of users" do
    render
    assert_select "table>tbody>tr" do | rows |
      assert_select rows[0], "td", :text => User.all[0].username
      assert_select rows[1], "td", :text => User.all[1].username
    end
#    assert_select "tr>td", :text => "Username".to_s, :count => 2
#    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
