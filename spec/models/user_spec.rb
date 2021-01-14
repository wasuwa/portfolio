require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      name: "example",
      email: "example@example.com"
    )
  }

  context 'when user is valid' do
    it 'valid' do
      expect(user).to be_valid
    end
    it 'no name' do
      user.name = ""
      expect(user).to be_invalid
    end
    it 'no email' do
      user.email = ""
      expect(user).to be_invalid
    end
  end

  context "when user's email needs to be unique" do
    it 'valid' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  context 'name length' do
    it '8 characters' do
      user.name = 'a' * 8
      expect(user).to be_valid
    end
    it '9 characters' do
      user.name = 'a' * 9
      expect(user).to be_invalid
    end
  end

  context 'email length' do
    it '255 characters' do
      user.email = 'a' * 243 + '@example.com'
      expect(user).to be_valid
    end
    it '256 characters' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to be_invalid
    end
  end
end