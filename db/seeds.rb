  TAGGINGS_TO_CREATE = 2000


  TAGGINGS_TO_CREATE.times do
    t = Tagging.create(game_id: rand(60)+1,
                    tag_id: 1+rand(8))
  end

  puts "Created #{TAGGINGS_TO_CREATE} taggings"
