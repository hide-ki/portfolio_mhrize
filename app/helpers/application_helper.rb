module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'MHRiseLayering'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def header
    if logged_in?
      case current_user.role
      when 'general'
        render 'shared/header'
      when 'admin'
        render 'shared/admin_header'
      end
    else
      render 'shared/before_login_header'
    end
  end
end
