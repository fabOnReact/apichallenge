require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#owns?' do 
    let(:user) { FactoryBot.build_stubbed(:user) }
    it 'returns true for owners' do 
      comment = double("comment", user: user)
      expect(user.owns?(comment)).to be(true)
    end

    it 'returns false for other users' do 
      another_user = double("another user")
      comment = double("comment", user: another_user)
      expect(user.owns?(comment)).to be(false)
    end
  end
end
