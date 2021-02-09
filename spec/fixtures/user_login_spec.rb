require 'rails_helper'

RSpec.describe "UserSetting" do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:another_user) { create(:user) }

  example 'ログインのテスト', type: :feature do
    posting
    within ".hamburger_nav" do
      click_on 'ログアウト'
    end
    # お気に入りボタンが表示されない
    expect(page).not_to have_selector "img[src$='/assets/no_active_star-1adb2db5fdc6fbc32fd48bde53fe6935457f7035536fe77e79fcaec6cb1d2c52.png']"
    # ログインする
    log_in_as(another_user)
    # flashメッセージが表示される
    expect(page).to have_content "ログインに成功しました"
    # showテンプレートにリダイレクトされる
    expect(current_url).to eq user_url(another_user)
    # ブログを書くボタンが表示される
    expect(page).to have_selector ".profile__button", text: "ブログを書く"
    # お気に入りボタンが表示される
    visit root_path
    expect(page).to have_selector "img[src$='/assets/no_active_star-1adb2db5fdc6fbc32fd48bde53fe6935457f7035536fe77e79fcaec6cb1d2c52.png']"
    within ".hamburger_nav" do
      click_on 'ログアウト'
    end
    visit user_path(another_user)
    # ブログを書くボタンが表示されない
    expect(page).not_to have_selector ".profile__button", text: "ブログを書く"
  end
end