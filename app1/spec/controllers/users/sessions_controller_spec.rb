require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_params) { {user:{email: user.email, password: user.password}} }
  let(:invalid_params){ {user:{email: user.email}} }
 
  describe "POST #create" do 
    before(:each) { @request.env["devise.mapping"] = Devise.mappings[:user] }
    it "returns the user token" do 
      post :create, params: valid_params, as: :json
      expect(json_response[:authentication_token]).to_not be_empty
    end

    it 'returns the error messages' do 
      post :create, params: invalid_params, as: :json
      expect(json_response[:error]).to eql("Invalid Email or password.")
    end
  end
end
