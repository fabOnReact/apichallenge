require 'rails_helper'

RSpec.describe "comments/new.html.erb", type: :view do
  it 'renders the view' do
    assign(:comment, FactoryBot.build_stubbed(:comment) )
    render
    expect(rendered).to match /Find me/
  end
end
