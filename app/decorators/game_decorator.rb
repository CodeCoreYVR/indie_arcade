class GameDecorator < Draper::Decorator
  delegate_all

  def reviews_count
    object.reviews.count
  end

  def title
    object.title.titleize
  end

  def last_in_arcade
    object.reviews.last ? formatted_date(object.reviews.last.created_at) : "Never"
  end

  def formatted_created_at
    formatted_date(object.created_at)
  end

  def type_display
    object.tags.map(&:name).join("&nbsp;|&nbsp;").html_safe
  end

  def download_button
    h.content_tag :div, class: "btn" do
      h.button_to "Download Game", h.game_path(object), method: :get
    end
  end

  private

  def formatted_date(date)
    date.strftime("%Y-%b-%d %H:%m")
  end
end
