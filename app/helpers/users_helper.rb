module UsersHelper
    def get_grade(user)
        if user.grade
            user.grade
        else
            "?"
        end
    end

    def get_user(joint)
        User.find_by(id: joint.user_id)
    end
end