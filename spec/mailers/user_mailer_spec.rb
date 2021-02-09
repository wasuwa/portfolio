require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  
  describe 'Mailer' do
    let(:mail) { UserMailer.password_reset(user) }
    before { user.reset_token = User.new_token }

      context '正しい宛先に送られた場合' do
        example 'パスワードのリセットリンクが表示される' do
          expect(mail.subject).to eq "パスワードをリセットします"
          expect(mail.to).to eq [user.email]
          expect(mail.from).to eq ['hssb.official@gmail.com']
        end
        example '正しい内容が表示される' do
          expect(mail.body).to have_content user.name
          expect(mail.body.encoded).to match user.reset_token
          expect(mail.body.encoded).to match CGI.escape(user.email)
        end
      end
  end
end