module ApplicationHelper
  def auth_page?
    request.path.start_with?("/login", "/signup")
  end

  def side_bar_pathname?(path)
    request.path.start_with?(path)
  end

  def side_bar_pathname_exact?(path)
    request.path == path
  end
end
