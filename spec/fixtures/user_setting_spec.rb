require 'rails_helper'

RSpec.describe "UserSetting" do
  let(:user) { create(:user) }

  example '新規登録のテスト', :type => :feature do
    log_in_as(user)
    visit edit_user_path(user)
    # 有効な送信をする
    fill_in 'user_name', :with => "aaaaaaa"
    fill_in 'user_email', :with => "aaaaaaa@aa.com"
    select 2, :from => '高校の学年'
    fill_in 'user_password', :with => "aaaaaa"
    fill_in 'user_password_confirmation', :with => "aaaaaa"
    attach_file 'user[icon]', "#{Rails.root}/spec/fixtures/img/rspec_test.jpg"
    click_on "更新する"
    # flashメッセージが表示される
    expect(page).to have_content "プロフィールの更新に成功しました"
    # プロフィールの表示が変更される
    expect(page).to have_selector ".profile__name", :text => "aaaaaa / 高校 2 年生"
    expect(page).not_to have_selector "img[src$='/assets/default_icon-43b9fbf38c3e2e5ea4de759a502cd7672bd431a1b56ca7ae8d00dc80e9909588.jpg']"
  end
end