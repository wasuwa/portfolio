require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :feature do

    let(:user) { build(:user) }

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
end
