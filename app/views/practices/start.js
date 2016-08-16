$("#play_area_container").html("<%= j (render partial: 'play_area', locals: { word: @word, choices: @choices, study: @study }) %>")
