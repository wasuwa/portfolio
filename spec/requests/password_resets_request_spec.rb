require 'rails_helper'

RSpec.describe "PasswordResets", type: :feature do
    let(:user) { create(:user) }

    before { user.create_reset_digest }
  
    describe 'password_resets' do
        context 'user sends an email' do
            it 'valid' do
                visit password_resets_path
                fill_in 'password_reset_email', with: user.email
                click_on '送信する'
                expect(current_path).to eq email_path
            end
            it 'no email' do
                visit password_resets_path
                fill_in 'password_reset_email', with: nil
                click_on '送信する'
                expect(current_path).to eq password_resets_path
                expect(page).to have_content 'そのメールアドレスは存在しません'
            end
            it 'invalid email' do
                visit password_resets_path
                fill_in 'password_reset_email', with: 'fjdklsj@jiosdfj.com'
                click_on '送信する'
                expect(current_path).to eq password_resets_path
                expect(page).to have_content 'そのメールアドレスは存在しません'
            end
        end
        context 'click the link in the email' do
            it 'valid' do
                visit edit_password_reset_url(user.reset_token, email: user.email)
                expect(current_url).to eq edit_password_reset_url(user.reset_token, email: user.email)
                expect(page).to have_no_content '無効なリンクです'
            end
            it 'invalid reset_token' do
                visit edit_password_reset_url('aaa', email: user.email)
                expect(current_url).to eq root_url
                expect(page).to have_content '無効なリンクです'
            end
            it 'invalid email' do
                visit edit_password_reset_url(user.reset_token, email: 'aaa@aaa.com')
                expect(current_url).to eq root_url
                expect(page).to have_content '無効なリンクです'
            end
            it 'email expiration date is invalid' do
                user.reset_sent_at = 3.hours.ago
                user.save!
                visit edit_password_reset_url(user.reset_token, email: user.email)
                expect(page).to have_content 'URLの有効期限が切れています'
                expect(current_url).to eq password_resets_url
            end
        end
        context 'user sends information' do

            before do
                visit edit_password_reset_url(user.reset_token, email: user.email)
            end

            it 'valid' do
                fill_in 'user_password', with: 'aaaaaa'
                fill_in 'user_password_confirmation', with: 'aaaaaa'
                click_on '更新する'
                expect(current_path).to eq user_path(user.id)
                expect(page).to have_content 'パスワードがリセットされました'
            end
            it 'different email address' do
                user.email = 'fdsafasdfsdf@dfsafasdfdsaf.com'
                user.save!
                fill_in 'user_password', with: 'aaaaaa'
                fill_in 'user_password_confirmation', with: 'aaaaaa'
                click_on '更新する'
                expect(current_url).to eq root_url
                expect(page).to have_content '無効なリンクです'
            end
            it 'no password' do
                fill_in 'user_password', with: nil
                fill_in 'user_password_confirmation', with: 'aaaaaa'
                click_on '更新する'
                expect(page).to have_content 'パスワードを入力してください'
            end
            it 'no password_confirmation' do
                fill_in 'user_password', with: 'aaaaaa'
                fill_in 'user_password_confirmation', with: nil
                click_on '更新する'
                expect(page).to have_content '確認とパスワードの入力が一致しません'
            end
            it 'invalid password' do
                fill_in 'user_password', with: 'aaa'
                fill_in 'user_password_confirmation', with: 'aaaaaa'
                click_on '更新する'
                expect(page).to have_content 'パスワードは6文字以上で入力してください'
                expect(page).to have_content '確認とパスワードの入力が一致しません'
            end
        end
    end
end