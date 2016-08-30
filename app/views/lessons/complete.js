$("#lesson_container").html("<%= j (render partial: 'lesson', locals: { lesson: @lesson, comment: @comment  } ) %>")
var $lesson_panel = $("#lesson_panel");
console.log("before scroll")
document.getElementById("#lesson_name").scrollIntoView();
console.log("should scroll")
