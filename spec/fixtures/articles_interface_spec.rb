require 'rails_helper'

RSpec.describe "ArticlesInterfaces", type: :feature do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:article) { create(:article) }

    before do
        
    end

    it 'articles interface' do
        log_in_as(user)
        visit user_path(user.id)
        
        # 有効な送信
        posting
        expect(page).to have_content '投稿に成功しました'
        expect(page).to have_no_selector "img[src='/assets/article_details_no_img-5387121c74cac5b563ed76a405038049fb52f825d40c1876fbaa1cc32d621c2b.jpg']"
        
        # ページネーションが正しく表示されているか
        expect(page).to have_no_content '1 2 3'

        # 投稿を削除する
        expect do
            page.accept_confirm do
                all(".article_items__button--delete")[0].click_on "delete"
            end
            expect(current_path).to user_path(user.id)
            expect(page).to have_content '記事が削除されました'
            expect(page).to have_content '記事はまだありません'
        end

        # 別のユーザーからの表示を確認
        log_in_as(other_user)
        posting
        log_in_as(user)
        visit user_path(other_user.id)
        expect(page).to have_no_selector '.profile__button', text: "ブログを書く"
        expect(page).to have_no_selector '.article_items__button--delete', text: "削除"
        expect(page).to have_no_selector '.article_items__button--edit', text: "編集"
        expect(page).to have_selector '.article_items__text--grade'
    end
end