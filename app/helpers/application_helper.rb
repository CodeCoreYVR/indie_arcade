module ApplicationHelper
 def display_picture(game)
   if game.nil?
     image_tag('/assets/fallback/default-feecc56fc0572402530a9509051a194266f25d1887ff725d395306367ed34c2f.png')
   elsif game.picture.nil?
     image_tag('app/assets/images/fallback/default.png')
   else
     image_tag(game.picture.url)
   end
 end
end
