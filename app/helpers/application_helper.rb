module ApplicationHelper
  def pagetitle(title)
    if title.present?
      "#{title} - BIGBAG Store"
    else
      "BIGBAG Store"
    end
  end
end
