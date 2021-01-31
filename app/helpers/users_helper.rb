module UsersHelper
    def confirmation_grade(user)
        if user.grade
            user.grade
        else
            "?"
        end
    end

    def each_user(user)
        User.find_by(id: user.user_id)
    end
end