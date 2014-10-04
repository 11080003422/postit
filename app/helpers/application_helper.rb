module ApplicationHelper
  def fix_address(link)
    link.start_with?('http://') ? link : 'http://' + link
  end

  def format_date(time)
    time.strftime("%A %b %e, %Y at %l:%M %P")
  end
end
