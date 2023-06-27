module ApplicationHelper
  def page_title(title)
    base_title = "BIGBAG Store"
    if title.present?
      "#{title} - #{base_title}"
    else
      base_title
    end
  end
end
