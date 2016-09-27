module ApplicationHelper
  def display_picture(game)
     unless game.picture.nil?
-      image_tag(game.picture)
+      image_tag(game.picture.url)
     else
       image_tag("app/assets/images/fallback/default.png")
      end
    end
end
