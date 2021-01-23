module RailsTestHelper

    def log_in_as(user)
        visit login_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        within '.settings__form' do
            click_on 'ログイン'
        end
    end

    def cookie_login(user, remember_me = '1')
        post login_path, params: { session: {
          email: user.email,
          password: user.password,
          remember_me: remember_me,
        } }
    end
end