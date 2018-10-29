require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  let(:valid_params) { {:user =>  FactoryBot.attributes_for(:user)} }
  it 'creates the user' do 
    expect { post '/users', params: valid_params }.to change(User, :count).by(1)
  end

  it 'redirect to the comments#index' do 
    post '/users', params: valid_params
    expect(response).to redirect_to(comments_path)
  end
end
