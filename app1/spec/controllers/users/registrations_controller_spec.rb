require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:valid_params) { {:user =>  FactoryBot.attributes_for(:user)} }

  describe "POST #create" do 
    before(:each) { @request.env["devise.mapping"] = Devise.mappings[:user] }
    it 'includes the users as json response' do 
      post :create, params: valid_params, as: :json
      expect(json_response[:email]).to eql valid_params[:user][:email]
    end

    it 'creates a new user' do 
      expect { post :create, params: valid_params, as: :json }.to change(User, :count).by(1)
    end
  end
end
