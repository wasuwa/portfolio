require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  context "articleが正しい場合" do
    example "バリデーションが通る" do
      expect(article).to be_valid
    end
  end

  context "articleのuser_idが空白の場合" do
    example "バリデーションが通らない" do
      article.user_id = nil
      expect(article).to be_invalid
    end
  end

  context "articleのtitleが空白の場合" do
    example "バリデーションが通らない" do
      article.title = nil
      expect(article).to be_invalid
    end
  end

  context "articleのcontentが空白の場合" do
    example "バリデーションが通らない" do
      article.content = nil
      expect(article).to be_invalid
    end
  end

  context "articleのcontentは30,000文字以下に制限される" do
    example "バリデーションが通る" do
      article.content = "a" * 30000
      expect(article).to be_valid
    end
    example "バリデーションが通らない" do
      article.content = "a" * 30001
      expect(article).to be_invalid
    end
  end

  context "articleのtitleは32文字以下に制限される" do
    example "バリデーションが通る" do
      article.title = "a" * 32
      expect(article).to be_valid
    end
    example "バリデーションが通らない" do
      article.title = "a" * 33
      expect(article).to be_invalid
    end
  end

  describe "articleの並び順" do
    let!(:day_before_yesterday) { FactoryBot.create(:article, :day_before_yesterday) }
    let!(:now) { FactoryBot.create(:article, :now) }  
    let!(:yesterday) { FactoryBot.create(:article, :yesterday) }

    context "articleの並び順は降順になる" do
      example "nowが最初に表示される" do
        expect(Article.first).to eq now
      end
    end
  end
  
  describe 'dependent: :destroy' do
    before do
      user.articles.create!(content: 'これはテストです', title: "これはテストです")
    end
    
    context 'userを削除した場合' do
      example 'userと同時にarticleも削除される' do
        expect do
          user.destroy
        end.to change(Article, :count).by(-1)
      end
    end
  end
end
