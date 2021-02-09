require 'rails_helper'

RSpec.describe "SignUp" do
  let(:user) { build(:user) }

  example '新規登録のテスト', type: :feature do
    # 有効な送信
    visit signup_path
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation
    within ".settings__form" do
      click_on "新規登録"
    end
    # flashメッセージ
    expect(page).to have_content "新規登録が完了しました"
    # プロフィールに内容が表示されているか
    expect(page).to have_selector ".profile__name", text: "#{user.name} / 高校 ? 年生"
  end
end