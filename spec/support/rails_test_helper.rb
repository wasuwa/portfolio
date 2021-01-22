module RailsTestHelper

    def log_in_as(user, remember = '1')
        post login_path, params: { session: {
            email: user.email,
            password: user.password,
            remember_me: remember} }
    end
end