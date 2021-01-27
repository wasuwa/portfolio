require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
    let(:user) { create(:user) }

    before { user.create_reset_digest }
  
    describe 'password_resets' do
        context 'user sends an email' do
            it 'valid' do
                get password_resets_path
                fill_in 
            end
            it 'no email' do
                
            end
            it 'invalid email' do
                
            end
        end
        # context 'user sends information' do
        #     it 'valid' do
                
        #     end
        #     it 'invalid user' do
                
        #     end
        #     it 'different email address' do
                
        #     end
        #     it 'no password' do
                
        #     end
        #     it 'no password_confirmation' do
                
        #     end
        #     it 'invalid password' do
                
        #     end
        #     it 'invalid password_confirmation' do
                
        #     end
        #     it 'email expiration date is invalid' do
                
        #     end
        # end
    end
end