module ApplicationHelper
  def display_picture(game)
    if game&.pictures[0].nil?
      image_tag(image_path('fallback/default'))
    else
      image_tag(game.pictures[0].large.url)
    end
  end
end
