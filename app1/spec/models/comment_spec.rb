require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '.find_comments' do 
    let(:comments) { double("comments") }
    it 'returns all comments' do 
      allow(Comment).to receive(:all).and_return comments 
      expect(Comment.find_comments("")).to be(comments)
    end

    it 'returns comments with the description' do
      allow(Comment).to receive(:with_description).with("with the description").and_return comments
      expect(Comment.find_comments("with the description")).to be(comments)
    end
  end

  describe '.with_description' do 
    it 'returns comments filtered by description' do 
      FactoryBot.create(:comment, description: 'missing')
      filtered_comment = FactoryBot.create(:comment, description: 'filtered')
      expect(Comment.find_comments('filtered')).to include filtered_comment
    end
  end
end
