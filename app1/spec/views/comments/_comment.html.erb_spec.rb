require 'rails_helper'

RSpec.describe "comments/_comment.html.erb", type: :view do
  let(:comment) { FactoryBot.build_stubbed(:comment) }

  context 'authenticated user' do 
    it 'does not include the update link' do
      allow(view).to receive(:current_user) { FactoryBot.build_stubbed(:user) }
      render :partial => "comments/comment.html.erb", :locals => {:comment => comment }
      expect(rendered).to_not match /edit/
    end

    it 'includes the update link' do
      allow(view).to receive(:current_user) { comment.user }
      render :partial => "comments/comment.html.erb", :locals => {:comment => comment }
      expect(rendered).to match /edit/
    end
  end
end
