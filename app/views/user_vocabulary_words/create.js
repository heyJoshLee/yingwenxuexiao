$("#vocabulary_words_container").html("<%= j (render partial: 'vocabulary_words/vocabulary_words_container', locals: { object: @object  } ) %>")
$("body").append("<%= j (render partial: 'shared/notification', locals: { message: 'Vocabulary Word added to your list!'  } ) %>")
$("#notification").fadeIn("slow", function() {
  $(this).fadeOut("slow");
});
