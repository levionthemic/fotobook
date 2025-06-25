module ApplicationHelper
  def auth_page?
    request.path.start_with?('/login', '/signup')
  end
end
