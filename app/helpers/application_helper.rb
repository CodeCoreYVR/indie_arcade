module ApplicationHelper
  def display_picture(game)
    if game.pictures.nil?
      image_tag('app/assets/images/fallback/default.png')
    else
      image_tag(game.pictures[0].url)
    end
  end
end
