module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # 1000倍の単位表示に変換する。
  def unit_conversion_to_1000_times(unit)
    if unit == "g"
      return "kg"
    else unit == "kg"
      return "t"
    end
  end
  
end
