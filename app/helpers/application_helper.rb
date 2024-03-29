module ApplicationHelper
  def full_title(page_title = "")
    base_title = "HSSB"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def full_url(path)
    # ドメインが決まり次第elseで分岐させリンクさせる
    domain = if Rails.env.development?
               'http://localhost:3000/'
             end
    "#{domain}#{path}"
  end
end
