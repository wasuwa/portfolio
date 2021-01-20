require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :feature do
  
    let(:user_valid) {
      User.create(
          name: "login",
          email: "login@login.com",
          password: "password",
          password_confirmation: "password"
      )
    }

    let(:user_invalid) { User.create() }

    describe 'login' do
      context 'submit information to the form' do
        it 'valid' do
          visit login_path
          fill_in 'session_email', with: user_valid.email
          fill_in 'session_password', with: user_valid.password
          within '.settings__form' do
            click_on 'ログイン'
          end
          expect(page).to have_no_content 'ログインに失敗しました'
          expect(page).to have_content 'ログアウト'
          visit user_path(user_valid.id)
          expect(page).to have_content 'login / 高校 ? 年生'
        end
        it 'invalid' do
          visit login_path
          fill_in 'session_email', with: user_invalid.email
          fill_in 'session_password', with: user_invalid.password
          within '.settings__form' do
            click_on 'ログイン'
          end
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインに失敗しました'
          visit root_path
          expect(page).to have_no_content 'ログインに失敗しました'
        end
        it 'no password' do
          visit login_path
          fill_in 'session_email', with: user_valid.email
          fill_in 'session_password', with: nil
          within '.settings__form' do
            click_on 'ログイン'
          end
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインに失敗しました'
          visit root_path
          expect(page).to have_no_content 'ログインに失敗しました'
        end
      end
    end
end
