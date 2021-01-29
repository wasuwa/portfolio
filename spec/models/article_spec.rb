require 'rails_helper'

RSpec.describe Article, type: :model do

  let(:article) { create(:article) }

  let(:user) { create(:user) }

  context 'when article is valid' do
    it 'valid' do
      expect(article).to be_valid
    end
    it 'no user_id' do
      article.user_id = nil
      expect(article).to be_invalid
    end
    it 'no content' do
      article.content = nil
      expect(article).to be_invalid
    end
    it 'no title' do
      article.title = nil
      expect(article).to be_invalid
    end
  end
  
  context 'content can be up to 30,000 characters in length' do
    it 'valid' do
      article.content = "a" * 30000
      expect(article).to be_valid
    end
    it 'invalid' do
      article.content = "a" * 30001
      expect(article).to be_invalid
    end
  end
  
  describe 'title' do
    context 'title can be up to 32 characters in length' do
      it 'valid' do
        article.title = "a" * 32
        expect(article).to be_valid
      end
      it 'invalid' do
        article.title = "a" * 33
        expect(article).to be_invalid
      end
    end
  end

  describe "Sort by latest" do
    let!(:day_before_yesterday) { FactoryBot.create(:article, :day_before_yesterday) }

    let!(:now) { FactoryBot.create(:article, :now) }

    let!(:yesterday) { FactoryBot.create(:article, :yesterday) }

    context 'articles are sorted in descending order' do
      it 'valid' do
        expect(Article.first).to eq now
      end
    end
  end
  
  describe 'dependent: :destroy' do
    before do
      user.save
      user.articles.create!(content: 'これはテストです', title: "これはテストです")
    end
    
    context 'if user is deleted, article is also deleted' do
      it 'valid' do
        expect do
          user.destroy
        end.to change(Article, :count).by(-1)
      end
    end
  end
end
