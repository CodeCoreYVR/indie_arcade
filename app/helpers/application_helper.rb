module ApplicationHelper
  def display_picture(game)
    if game.picture.nil?
      image_tag('app/assets/images/fallback/default.png')
    else
      image_tag(game.picture.url)
    end
  end

  # def background_path(game)
  #   if game.picture.nil?
  #     image_url('fallback/default.png')
  #   else
  #     game.picture.url
  #   end
  # end
end
