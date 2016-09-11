module ApplicationHelper
  def display_picture(game)
    unless game.picture.nil?
      image_tag(game.picture)
    else
      image_tag("app/assets/images/fallback/defaultdfa.png")
     end
  end
end
