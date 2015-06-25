require 'rails_helper'

RSpec.describe "lines/new", type: :view do
  before(:each) do
    assign(:line, Line.new(
      :content => "MyText"
    ))
  end

  it "renders new line form" do
    render

    assert_select "form[action=?][method=?]", lines_path, "post" do

      assert_select "textarea#line_content[name=?]", "line[content]"
    end
  end
end
