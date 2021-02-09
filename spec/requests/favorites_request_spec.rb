require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:favorite) { create(:favorite, user_id: user.id, article_id: article.id) }

  describe "create" do
    context "有効なパラメータが送信された場合" do
      example "お気に入りに登録される" do
        expect do
          favorite.save
        end.to change(Favorite, :count).by(1)
      end
    end
  end

  describe "destroy" do
    context "有効なパラメータが送信される場合" do
      before do
        favorite.save
      end
      example "お気に入りが削除される" do
        expect do
          favorite.destroy
        end.to change(Favorite, :count).by(-1)
      end
    end
  end
end
