require 'rails_helper'

RSpec.describe "PasswordResets", :type => :feature do
  let(:user) { create(:user) }
  before { user.create_reset_digest }

  describe "create" do
    context "userから有効なパラメータが送信された場合" do
      example "emailが送信される" do
        visit password_resets_path
        fill_in 'password_reset_email', :with => user.email
        click_on '送信する'
        expect(current_path).to eq email_path
      end
    end

    context "userから無効なパラメータが送信された場合" do
      before do
        visit password_resets_path
        fill_in 'password_reset_email', :with => nil
        click_on '送信する'
      end
      example "元のページにリダイレクトされる" do
        expect(current_path).to eq password_resets_path
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content 'そのメールアドレスは存在しません'
      end
    end

    context "userから空のemailが送信された場合" do
      before do
        visit password_resets_path
        fill_in 'password_reset_email', :with => nil
        click_on '送信する'
      end
      example "元のページにリダイレクトされる" do
        expect(current_path).to eq password_resets_path
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content 'そのメールアドレスは存在しません'
      end
    end
  end

  describe "create" do
    context "有効なリンクをクリックした場合" do
      example "パスワードをリセットするurlにリダイレクトされる" do
        visit edit_password_reset_url(user.reset_token, :email => user.email)
        expect(current_url).to eq edit_password_reset_url(user.reset_token, :email => user.email)
      end
    end
  end

  describe "update" do
    before do
      visit edit_password_reset_url(user.reset_token, :email => user.email)
    end

    context "有効なパラメータが送信された場合" do
      example "パスワードがリセットされる" do
        fill_in 'user_password', :with => 'aaaaaa'
        fill_in 'user_password_confirmation', :with => 'aaaaaa'
        click_on '更新する'
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'パスワードが更新されました'
      end
    end

    context "emailを途中で変更した場合" do
      before do
        user.email = 'fdsafasdfsdf@dfsafasdfdsaf.com'
        user.save!
        fill_in 'user_password', :with => 'aaaaaa'
        fill_in 'user_password_confirmation', :with => 'aaaaaa'
        click_on '更新する'
      end
      example "TOPページにリダイレクトされる" do
        expect(current_url).to eq root_url
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content '無効なリンクです'
      end
    end

    context "パスワードが空の場合" do
      example "エラーメッセージが表示される" do
        fill_in 'user_password', :with => nil
        fill_in 'user_password_confirmation', :with => 'aaaaaa'
        click_on '更新する'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context "パスワードの確認が空の場合" do
      example "エラーメッセージが表示される" do
        fill_in 'user_password', :with => nil
        fill_in 'user_password_confirmation', :with => 'aaaaaa'
        click_on '更新する'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context "パスワードの確認が空の場合" do
      example "エラーメッセージが表示される" do
        fill_in 'user_password', :with => 'aaaaaa'
        fill_in 'user_password_confirmation', :with => nil
        click_on '更新する'
        expect(page).to have_content '確認とパスワードの入力が一致しません'
      end
    end

    context "パスワードが無効の場合" do
      example "エラーメッセージが表示される" do
        fill_in 'user_password', :with => 'aaa'
        fill_in 'user_password_confirmation', :with => 'aaaaaa'
        click_on '更新する'
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
        expect(page).to have_content '確認とパスワードの入力が一致しません'
      end
    end
  end

  describe "before" do
    context "トークンが無効の場合" do
      before do
        visit edit_password_reset_url('aaa', :email => user.email)
      end
      example "TOPページにリダイレクトされる" do
        expect(current_url).to eq root_url
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content '無効なリンクです'
      end
    end

    context "emailが無効の場合" do
      before do
        visit edit_password_reset_url(user.reset_token, :email => 'aaa@aaa.com')
      end
      example "TOPページにリダイレクトされる" do
        expect(current_url).to eq root_url
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content '無効なリンクです'
      end
    end

    context "emailの有効期限が無効の場合" do
      before do
        user.reset_sent_at = 3.hours.ago
        user.save!
        visit edit_password_reset_url(user.reset_token, :email => user.email)
      end
      example "emailを送信するurlにリダイレクトされる" do
        expect(current_url).to eq password_resets_url
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content 'URLの有効期限が切れています'
      end
    end
  end
end
