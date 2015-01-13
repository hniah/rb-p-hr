module ApplicationHelper
  def display_page_title(title)
    render partial: 'shared/breadcrumb', locals: { page_title: title }
  end

  def label_name(key)
    t("helpers.label.#{key}")
  end

  def to_unsigned_integer(num)
    num = 0 if num < 0
    return num
  end
end
