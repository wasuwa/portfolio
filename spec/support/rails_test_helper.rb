module RailsTestHelper

    def log_in_as(user)
        visit login_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        within '.settings__form' do
            click_on 'ログイン'
        end
    end

    def posting
        visit new_article_path
        fill_in 'article_title', with: "これはテストです"
        attach_file 'article[image]', "#{Rails.root}/spec/fixtures/img/rspec_test.jpg"
        fill_in 'article_content', with: "これはテストです"
        click_on '投稿する'
    end

    def cookie_login(user, remember_me = '1')
        post login_path, params: { session: {
          email: user.email,
          password: user.password,
          remember_me: remember_me,
        } }
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end
end