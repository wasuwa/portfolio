require 'rails_helper'

RSpec.describe "Sessions", :type => :request do
  let(:user) { create(:user) }

  describe 'new' do
    context "有効なパラメータが送信された場合" do
      example "リクエストが成功する" do
        get login_path
        expect(response.status).to eq 200
      end
    end
  end

  describe "create", :type => :feature do
    let(:user_invalid) { User.create }

    context "有効なパラメータが送信された場合" do
      before do
        log_in_as(user)
      end
      example "ログインに成功する" do
        expect(page).to have_content "ログインに成功しました"
      end
      example "showテンプレートが表示される" do
        expect(current_path).to eq user_path(user)
      end
    end

    context "無効なパラメータが送信された場合" do
      before do
        visit login_path
        fill_in 'session_email', :with => nil
        fill_in 'session_password', :with => nil
        within '.settings__form' do
          click_on 'ログイン'
        end
      end
      example "ログインに失敗する" do
        expect(page).to have_content 'ログインに失敗しました'
      end
      example "login_pathにリダイレクトされる" do
        expect(current_path).to eq login_path
      end
    end
  end

  describe "destroy", :type => :feature do
    context "有効なパラメータが送信された場合" do
      before do
        log_in_as(user)
        within ".hamburger_nav" do
          click_on 'ログアウト'
        end
      end
      example "ログアウトする" do
        expect(page).to have_content 'ログアウトに成功しました'
      end
      example "root_pathにリダイレクトされる" do
        expect(current_path).to eq root_path
      end
    end
  end

  describe 'cookie' do
    context 'userがremember_meをクリックした場合' do
      it 'cookieに値が保存される' do
        cookie_login(user)
        expect(cookies['remember_token']).not_to eq nil
      end
    end
  end
end
