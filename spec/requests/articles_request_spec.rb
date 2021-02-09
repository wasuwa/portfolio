require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:article) { create(:article) }
  let(:user) { create(:user) }

  describe "index" do
    context "有効なパラメータが送信された場合" do
      example "リクエストが成功する" do
        get articles_path
        expect(response.status).to eq 200
      end
    end
  end

  describe "create", type: :feature do
    let(:post_request) { post articles_path, params: { article: article } }

    context "有効なパラメータが送信された場合" do
      before do
        posting
      end
      example "投稿が成功する" do
        expect(page).to have_content "投稿に成功しました"
      end
      example "showテンプレートにリダイレクトされる" do
        expect(current_path).to eq user_path(user)
      end
    end

    context "無効なパラメータが送信された場合" do
      before do
        log_in_as(user)
        visit new_article_path
        fill_in 'article_title', with: ""
        fill_in 'article_content', with: ""
        click_on '投稿する'
      end
      example "newテンプレートがレンダリングされる" do
        expect(current_path).to eq articles_path
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "本文を入力してください"
      end
    end
  end

  describe "update", type: :feature do
    context "有効なパラメータが送信された場合" do
      before do
        log_in_as(user)
        visit edit_article_path(article)
        fill_in 'article_title', with: "updateします"
        fill_in 'article_content', with: "updateします"
        click_on '更新する'
      end
      example "showテンプレートにリダイレクトされる" do
        expect(current_path).to eq article_path(article)
      end
      example "記事が更新される" do
        article.reload
        expect(article.title).to eq "updateします"
        expect(article.content).to eq "updateします"
      end
      example "flashメッセージが表示される" do
        expect(page).to have_content "記事の更新に成功しました"
      end
    end

    context "無効なパラメータが送信された場合" do
      before do
        log_in_as(user)
        visit edit_article_path(article)
        fill_in 'article_title', with: ""
        fill_in 'article_content', with: ""
        click_on '更新する'
      end
      example "editテンプレートがレンダリングされる" do
        expect(current_path).to eq article_path(article)
      end
      example "エラーメッセージが表示される" do
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "本文を入力してください"
      end
    end
  end

  describe "show" do
    context "有効なパラメータが送信された場合" do
      example "リクエストが成功する" do
        get article_path(article)
        expect(response.status).to eq 200
      end
    end
  end

  describe "destroy", type: :feature do
    let(:delete_request) { delete article_path(article) }

    context "有効なパラメータが送信された場合" do
      before do
        posting
        visit user_path(user)
        click_on "削除"
      end
      example "記事が削除される" do
        expect(page).to have_content "記事はまだありません"
      end
      example "flashメッセージが表示される" do
        expect(page).to have_content "記事が削除されました"
      end
      example "元いたページにリダイレクトされる" do
        expect(current_path).to eq user_path(user)
      end
    end
  end

  describe "before", type: :feature do
    let(:another_user) { create(:user) }

    context "未ログインのuserがindex、showアクション以外にアクセスした場合" do
      before do
        log_in_as(another_user)
        posting
        within ".hamburger_nav" do
          click_on 'ログアウト'
        end
        visit edit_article_path(article)
      end
      example 'login_urlにリダイレクトされる' do
        expect(current_url).to eq login_url
      end
      example "flashメッセージが表示される" do
        expect(page).to have_content "この機能を使うためにはログインが必要です"
      end
    end

    context "別のuserがdestroyアクションにアクセスした場合" do
      before do
        log_in_as(user)
        posting
        within ".hamburger_nav" do
          click_on 'ログアウト'
        end
        log_in_as(another_user)
        delete article_path(article)
      end
      example "showテンプレートにリダイレクトされる" do
        expect(current_path).to eq user_path(another_user)
      end
    end
  end
end