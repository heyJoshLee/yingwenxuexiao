$("#question_body").val("");
$("#question_body").focus();
$("#question_value").val(10);
$("body").append("<%= j (render partial: 'shared/notification', locals: {message: 'Question Created'} )%>");
$("#notification").fadeIn(1000);
$("#notification").fadeOut(1000);
var $container = $("#editing_questions_container")
$container.prepend("<%= j (render partial: 'admin/quizzes/question', locals: { question: @question, course: @course, lesson: @lesson, quiz: @quiz  } ) %>");
