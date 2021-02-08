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
end