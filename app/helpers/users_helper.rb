module UsersHelper
  def get_grade(user)
    if user.grade
      user.grade
    else
      "?"
    end
  end
end
