require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }
  
  describe 'current_user' do
    before do
      remember(user)
    end
    
    context 'sessionがnilの場合' do
      example '正しいuserを返す' do
        expect(current_user).to eq user
        expect(current_user).to be_truthy
      end
    end

    context 'remember_digestが間違っている場合' do
      example 'nilを返す' do
        user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end