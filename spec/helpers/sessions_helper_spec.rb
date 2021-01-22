require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

    let(:user) { create(:user) }
    
    describe 'current_user' do
        before do
            remember(user)
        end
        context 'returns the correct user if the session is nil' do
            it 'valid' do
                expect(current_user).to eq user
                expect(current_user).to be_truthy
            end
        end
        context 'current_user returns nil when remember digest is wrong' do
            it 'valid' do
                user.update_attribute(:remember_digest, User.digest(User.new_token))
                expect(current_user).to eq nil
            end
        end
    end
end