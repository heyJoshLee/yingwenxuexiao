var $input = $("#question-<%=@question.slug%> input[type=text");
$input.val("");
$input.focus();
$("#question-<%=@question.slug%> .question_choices").append("<%= j (render partial: 'admin/quizzes/choice', locals: {choice: @choice, question: @question} )%>");
$("body").append("<%= j (render partial: 'shared/notification', locals: {message: 'Choice Created'} )%>");
$("#notification").fadeIn(1000);
$("#notification").fadeOut(1000);
