require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { create(:user) }

  context "userが正しい場合" do
    example "バリデーションが通る" do
      expect(user).to be_valid
    end
  end

  context "userのnameが空白の場合" do
    example "バリデーションが通らない" do
      user.name = ""
      expect(user).to be_invalid
    end
  end

  context "userのemailが空白の場合" do
    example "バリデーションが通らない" do
      user.email = ""
      expect(user).to be_invalid
    end
  end

  context "userのpasswordが空白の場合" do
    example "バリデーションが通らない" do
      user.password = user.password_confirmation = ""
      expect(user).to be_invalid
    end
  end

  context "userのemailが重複している場合" do
    example "バリデーションが通らない" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  context "userのnameは8文字以下に制限する" do
    example "バリデーションが通る" do
      user.name = 'a' * 8
      expect(user).to be_valid
    end
    example "バリデーションが通らない" do
      user.name = 'a' * 9
      expect(user).to be_invalid
    end
  end

  context "userのemailは255文字以下に制限する" do
    example "バリデーションが通る" do
      user.email = 'a' * 243 + '@example.com'
      expect(user).to be_valid
    end
    example "バリデーションが通らない" do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to be_invalid
    end
  end

  context "userのpasswordは6文字以上に制限する" do
    example "バリデーションが通る" do
      user.password = user.password_confirmation = "a" * 6
      expect(user).to be_valid
    end
    example "バリデーションが通らない" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end

  context "userのgradeは1,2,3,nil以外を制限する" do
    example "バリデーションが通る" do
      user.grade = 1
      expect(user).to be_valid
    end
    example "バリデーションが通る" do
      user.grade = 2
      expect(user).to be_valid
    end
    example "バリデーションが通る" do
      user.grade = 3
      expect(user).to be_valid
    end
    example "バリデーションが通る" do
      user.grade = nil
      expect(user).to be_valid
    end
    example "バリデーションが通らない" do
      user.grade = 4
      expect(user).to be_invalid
    end
    example "バリデーションが通らない" do
      user.grade = "a"
      expect(user).to be_invalid
    end
  end

  context "userのemailは無効な形を受けつけない場合" do
    example "バリデーションが通る" do
      valid_emails = %w[user@example.com USER@example.COM U_S-ER@foo.bar.jp aiueo.kaki@foo.org abc+dfg@baz.blog]
      valid_emails.each do |emails|
        user.email = emails
        expect(user).to be_valid
      end
    end
    example "バリデーションが通らない" do
      valid_emails = %w[user@example,com USERexample.COM U_S-ER@foo. aiueo.kaki@fo_o.org abc+dfg@baz+bazz.blog user@user..com]
      valid_emails.each do |emails|
        user.email = emails
        expect(user).to be_invalid
      end
    end
  end

  context "userのemailは小文字で保存される" do
    example "大文字になる" do
      user.email = 'aaa@FOobar.cOM'
      user.save!
      expect(user.email).to eq 'aaa@foobar.com'
    end
  end
end