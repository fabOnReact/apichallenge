require 'rails_helper'

RSpec.describe "layouts/application.html.erb", type: :view do
  it 'display error messages' do 
    flash[:error] = 'Something went wrong'
    render 
    expect(rendered).to match /Something went wrong/
  end
end
