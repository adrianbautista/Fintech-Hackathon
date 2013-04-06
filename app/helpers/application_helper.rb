module ApplicationHelper

  def logo_helper
    if current_user
      user_path(current_user)
    else
      root_path
    end
  end

end
