module ApplicationHelper

  def logo_helper
    if current_user
      user_path(current_user)
    else
      root_path
    end
  end
  def right_helper
    if current_user
      link_to 'My Dashboard', user_path(current_user)
    end
  end

end
