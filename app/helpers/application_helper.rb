module ApplicationHelper
  def display_picture(game)
    if game&.picture.nil?
      image_tag(image_path('fallback/default'))
    else
      image_tag(game.picture.url)
    end
  end
end
