require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user) { create(:user) }
  
  let(:mail) { UserMailer.password_reset(user) }

    describe 'Mailer' do
      context 'email is sent by mailer' do
        it 'valid' do
          expect(mail.subject).to eq "パスワードをリセットします"
          expect(mail.to).to eq user.email
          expect(mail.from).to eq ENV["GMAIL_NAME"]
        end
      end
    end
end