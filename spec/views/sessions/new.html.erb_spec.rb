require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :feature do
  
    let(:user_valid) {
      User.new(
          email: "login@login.com",
          password: "password"
      )
    }

    let(:user_invalid) { User.create() }

    describe 'login' do
      context 'submit information to the form' do
        it 'valid' do
          visit login_path
          fill_in 'session_email', with: user_invalid.email
          fill_in 'session_password', with: user_invalid.password
          click_on 'ログイン'
          expect(page).to have_content 'ログインに失敗しました'
          visit root_path
          expect(page).to have_no_content 'ログインに失敗しました'
        end
        # it 'invalid' do
          
        # end
      end
    end
end
