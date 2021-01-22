require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :feature do

    let(:user) { build(:user) }

    let(:login) { create(:user) }

    let(:invalid) {
        User.create()
    }

    describe 'signup' do
        context 'submit information to the form' do
            it 'valid' do
                visit new_user_path
                fill_in 'user_name', with: user.name
                fill_in 'user_email', with: user.email
                fill_in 'user_password', with: user.password
                fill_in 'user_password_confirmation', with: user.password_confirmation
                within '.settings__form' do
                    click_on '新規登録'
                end
                expect(page).to have_content '新規登録が完了しました'
                visit root_path
                expect(page).to have_no_content '新規登録が完了しました'
                expect(page).to have_content 'ログアウト'
            end
            it 'invalid' do
                visit new_user_path
                fill_in 'user_name', with: invalid.name
                fill_in 'user_email', with: invalid.email
                fill_in 'user_password', with: invalid.password
                fill_in 'user_password_confirmation', with: invalid.password_confirmation
                within '.settings__form' do
                    click_on '新規登録'
                end
                expect(current_path).to eq users_path
                expect(invalid.errors).to be_added(:name, :blank)
                expect(invalid.errors).to be_added(:email, :blank)
                expect(invalid.errors).to be_added(:password, :blank)
                expect(invalid.errors).to be_added(:password_confirmation, :blank)
            end
        end
    end

    describe 'setting', type: :request do
        context 'send information to form' do
            it 'valid' do
                log_in_as(login)
                visit edit_user_path(login)
                fill_in 'user_name', with: login.name = "foobar"
                select 2, from: "高校の学年"
                fill_in 'user_email', with: login.email = "foobar@foobar.com"
                fill_in 'user_password', with: nil
                fill_in 'user_password_confirmation', with: nil
                click_on '更新する'
                expect(page).to have_content 'プロフィールの編集に成功しました'
                expect(current_path).to eq user_path(login)
                expect(page).to have_content 'foobar / 高校 2 年生'
                visit current_path
                expect(page).to have_no_content 'プロフィールの編集に成功しました'
            end
            it 'invalid' do
                log_in_as(login)
                visit edit_user_path(login)
                fill_in 'user_name', with: login.name = nil
                select 1, from: "高校の学年"
                fill_in 'user_email', with: login.email = nil
                fill_in 'user_password', with: login.password = "aaafds"
                fill_in 'user_password_confirmation', with: login.password_confirmation = "aaaiii"
                click_on '更新する'
                expect(page).to have_content '名前を入力してください'
                expect(page).to have_content 'メールアドレスを入力してください'
                expect(page).to have_content '確認とパスワードの入力が一致しません'
            end
            it 'no password' do
                log_in_as(login)
                visit edit_user_path(login)
                fill_in 'user_name', with: login.name
                fill_in 'user_email', with: login.email
                fill_in 'user_password_confirmation', with: login.password_confirmation = "aaaiii"
                click_on '更新する'
                expect(page).to have_content 'パスワードを入力してください'
            end
            it 'no password_confirmation' do
                log_in_as(login)
                visit edit_user_path(login)
                fill_in 'user_name', with: login.name
                fill_in 'user_email', with: login.email
                fill_in 'user_password', with: login.password = "aaaiii"
                click_on '更新する'
                expect(page).to have_content '確認とパスワードの入力が一致しません'
            end
        end
    end
end