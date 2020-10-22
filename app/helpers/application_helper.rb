module ApplicationHelper
  def full_title(page_title)
    if page_title.blank?
      SITE_TITLE
    else
      "#{page_title} - #{SITE_TITLE}"
    end
  end
end
