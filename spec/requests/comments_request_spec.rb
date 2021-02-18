require 'rails_helper'

RSpec.describe "Comments", :type => :request do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { create(:comment, :user_id => user.id, :article_id => article.id) }

  describe "create" do
    context "有効なパラメータが送信された場合" do
      example "お気に入りに登録される" do
        expect do
          comment.save
        end.to change(Comment, :count).by(1)
      end
    end
  end

  describe "destroy" do
    context "有効なパラメータが送信される場合" do
      before do
        comment.save
      end
      example "お気に入りが削除される" do
        expect do
          comment.destroy
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
