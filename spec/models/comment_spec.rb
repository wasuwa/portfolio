require 'rails_helper'

RSpec.describe Comment, type: :feature do
  
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { create(:comment) }

  context "コメントが正しい場合" do
    example 'バリデーションが通る' do
      expect(comment).to be_valid
    end
  end

  context "コメントのcontentが空白の場合" do
    example "バリデーションが通らない" do
      comment.content = ""
      expect(comment).to be_invalid
    end
  end

  context "コメントのcontentが140文字以下の場合" do
    example "バリデーションが通る" do
      comment.content = "a" * 140
      expect(comment).to be_valid
    end
  end

  context "コメントのcontentの文字数が140文字より多い場合" do
    example "バリデーションが通らない" do
      comment.content = "a" * 141
      expect(comment).to be_invalid
    end
  end

  describe "commentの並び順" do
    let!(:day_before_yesterday) { create(:comment, :day_before_yesterday) }
    let!(:now) { create(:comment, :now) }  
    let!(:yesterday) { create(:comment, :yesterday) }

    context "articleの並び順は降順になる" do
      example "nowが最初に表示される" do
        expect(Comment.first).to eq now
      end
    end
  end

  describe "dependent: :destroy" do
    before do
      article.comments.create!(content: 'これはテストです', user_id: user.id)
    end
    
    context 'articleを削除した場合' do
      example 'articleと同時にcommentも削除される' do
        expect do
          article.destroy
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end