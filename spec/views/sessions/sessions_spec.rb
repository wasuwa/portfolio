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
          expect(page).to have_content 'ログインに成功しました'
          expect(page).to have_no_content 'ログインに失敗しました'
          expect(page).to have_content 'ログアウト'
          visit user_path(user_valid.id)
          expect(page).to have_content 'login / 高校 ? 年生'
          expect(page).to have_no_content 'ログインに成功しました'
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

    describe 'logout' do
      context 'click the logout link' do
        it 'valid' do
          visit login_path
          fill_in 'session_email', with: user_valid.email
          fill_in 'session_password', with: user_valid.password
          within '.settings__form' do
            click_on 'ログイン'
          end
          expect(page).to have_content 'ログインに成功しました'
          within '.hamburger_nav' do
            click_on 'ログアウト'
          end
          expect(current_path).to eq root_path
          expect(page).to have_content 'ログアウトに成功しました'
          visit current_path
          expect(page).to have_no_content 'ログアウトに成功しました'
        end
      end
    end

    describe 'remember me', type: :request do
      context 'remembers the cookie when user checks the remember me box' do
        it 'valid' do
          log_in_as(user_valid)
          expect(cookies[:remember_token]).to_not eq nil
        end
        it 'invalid' do
          log_in_as(user_valid, '0')
          expect(cookies[:remember_token]).to eq nil
        end
      end
    end
end
