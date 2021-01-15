require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      name: "example",
      email: "example@example.com",
      password: "password",
      password_confirmation: "password",
      grade: 2
    )
  }

  context 'when user is valid' do
    it 'valid' do
      expect(user).to be_valid
    end
    it 'no name' do
      user.name = ""
      expect(user).to be_invalid
    end
    it 'no email' do
      user.email = ""
      expect(user).to be_invalid
    end
    it 'no password' do
      user.password = user.password_confirmation = ""
      expect(user).to be_invalid
    end
    it 'grade is a letter' do
      user.grade = "a"
      expect(user).to be_invalid
    end
  end

  context "email needs to be unique" do
    it 'valid' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  context 'name can be up to 8 characters in length' do
    it '8 characters' do
      user.name = 'a' * 8
      expect(user).to be_valid
    end
    it '9 characters' do
      user.name = 'a' * 9
      expect(user).to be_invalid
    end
  end

  context 'Email length up to 255 characters' do
    it '255 characters' do
      user.email = 'a' * 243 + '@example.com'
      expect(user).to be_valid
    end
    it '256 characters' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to be_invalid
    end
  end

  context 'Password length is 6 characters or more' do
    it '6 characters' do
      user.password = user.password_confirmation = "a" * 6
      expect(user).to be_valid
    end
    it '5 characters' do
      user.password = user.password_confirmation = "a" * 5
      expect(user).to be_invalid
    end
  end
  
  context 'grade is 1 or more and 3 or less' do
    it '1' do
      user.grade = 1
      expect(user).to be_valid
    end
    it '3' do
      user.grade = 3
      expect(user).to be_valid
    end
    it '4' do
      user.grade = 4
      expect(user).to be_invalid
    end
  end

  context 'when email format is invalid' do
    it 'valid' do
      valid_emails = %w[user@example.com USER@example.COM U_S-ER@foo.bar.jp aiueo.kaki@foo.org abc+dfg@baz.blog]
      valid_emails.each do |emails|
        user.email = emails
        expect(user).to be_valid
      end
    end
    it 'invalid' do
      valid_emails = %w[user@example,com USERexample.COM U_S-ER@foo. aiueo.kaki@fo_o.org abc+dfg@baz+bazz.blog user@user..com]
      valid_emails.each do |emails|
        user.email = emails
        expect(user).to be_invalid
      end
    end
  end

  context 'if the email is saved in lowercase' do
    it 'valid' do
      user.email = 'aaa@FOobar.cOM'
      user.save!
      expect(user.email).to eq 'aaa@foobar.com'
    end
  end
end