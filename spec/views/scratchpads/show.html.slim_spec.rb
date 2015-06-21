require 'rails_helper'

RSpec.describe "scratchpads/show", type: :view do
  before(:each) do
    @scratchpad = assign(:scratchpad, Fabricate(:scratchpad))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@scratchpad.title)
    expect(rendered).to match(@scratchpad.description)
  end
end
