require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user)} 
  let(:comment) { instance_double("comment")}
  let(:comment_stub) { FactoryBot.build_stubbed(:comment) }
  let(:valid_params) { {comment: { message: 'test', description: 'some test'}}}
  let(:invalid_params) { {comment: { message: 'test'}}}

  login_user

  describe "GET #index" do it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      comments = double("comments")
      expect(controller.current_user).to receive(:comments).and_return comments
      expect(comments).to receive(:find).with("1").and_return comment
      get :edit, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do 
      it "redirects to comments/show page(no saving)" do
        expect(Comment).to receive(:new).and_return comment_stub
        allow(comment_stub).to receive(:save).and_return true
        get :create, params: valid_params, as: :html
        expect(response).to redirect_to(comment_path(comment_stub))
      end

      it "render the json response(with saving)" do
        post :create, params: valid_params, as: :json
        expect(response).to have_http_status(:created)
        expect(json_response[:message]).to eql(valid_params[:comment][:message])
      end
    end

    context "with invalid parameters" do 
      it "re-renders the new template" do 
        expect(Comment).to receive(:new).and_return comment_stub
        allow(comment_stub).to receive(:save).and_return false
        get :create, params: valid_params, as: :html
        expect(response).to render_template(:new)
      end

      it "renders the errors in the json response body" do 
        get :create, params: invalid_params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:errors]).to eql({:description=>["can't be blank"]})
      end
    end
  end
end
