require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user) { create(:user) }
  
  describe 'Mailer' do
    before { user.reset_token = User.new_token }

    let(:mail) { UserMailer.password_reset(user) }

      context 'sent to the correct user' do
        it 'valid' do
          expect(mail.subject).to eq "パスワードをリセットします"
          expect(mail.to).to eq [user.email]
          expect(mail.from).to eq ['hssb.official@gmail.com']
        end
      end
      context 'correct content is sent' do
        it 'valid' do
          expect(mail.body).to have_content user.name
          expect(mail.body.encoded).to match user.reset_token
          expect(mail.body.encoded).to match CGI.escape(user.email)
        end
      end
    end
end