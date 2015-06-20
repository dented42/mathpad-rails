require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, Fabricate(:user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@user.username)
    ## email isn't shown by default.
    # expect(rendered).to match(@user.email)
  end
end
