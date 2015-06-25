require 'rails_helper'

RSpec.describe "lines/edit", type: :view do
  before(:each) do
    @line = assign(:line, Line.create!(
      :content => "MyText"
    ))
  end

  it "renders the edit line form" do
    render

    assert_select "form[action=?][method=?]", line_path(@line), "post" do

      assert_select "textarea#line_content[name=?]", "line[content]"
    end
  end
end
