require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { FactoryBot.create(:user)} 
  let(:valid_params) { {comment: { message: 'test', description: 'some test'}}}
  let(:comment_stub) { FactoryBot.build_stubbed(:comment) }

  describe "POST /comments" do 
    before(:each) do 
      allow(Comment).to receive(:new).and_return comment_stub
      allow(comment_stub).to receive(:save).and_return true
    end
      
    context "with valid API credentials" do
      it "redirect the user the the home page" do 
        post "/comments", params: valid_params, headers: {"X-User-Email" => user.email, "X-User-Token" => user.authentication_token}
        expect(response.status).to be(302)
        expect(response).to redirect_to(comment_stub)
      end
    end

    context "with invalid API credentials" do 
      it "renders an error message" do 
        post "/comments"
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /comments" do 
    context "with valid API credentials" do
      it "redirect the user the the home page" do 
        get comments_path, headers: {"X-User-Email" => user.email, "X-User-Token" => user.authentication_token}
        expect(response.status).to be(200)
      end
    end

    context "with invalid API credentials" do 
      it "renders an error message" do 
        get comments_path
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
