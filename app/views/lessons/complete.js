$("#lesson_container").html("<%= j (render partial: 'lesson', locals: { lesson: @lesson, comment: @comment  } ) %>")
var $lesson_panel = $("#lesson_panel");
window.scrollTo(0, 400);
