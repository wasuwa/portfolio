require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :feature do
    let(:user_valid) {
        User.create(
          name: "example",
          email: "example@example.com",
          password: "password",
          password_confirmation: "password",
          grade: 2
        )
    }

    let(:user_invalid) { User.create() }

    describe 'signup' do
        context 'send invalid information' do
            it 'invalid' do
                visit new_user_path
                fill_in 'user_name', with: user_invalid.name
                fill_in 'user_email', with: user_invalid.email
                fill_in 'user_password', with: user_invalid.password
                fill_in 'user_password_confirmation', with: user_invalid.password_confirmation
                click_on '新規登録'
                expect(current_path).to eq users_path
                expect(user_invalid.errors).to be_added(:name, :blank)
                expect(user_invalid.errors).to be_added(:email, :blank)
                expect(user_invalid.errors).to be_added(:password, :blank)
                expect(user_invalid.errors).to be_added(:password_confirmation, :blank)
            end
        end
    end
end
