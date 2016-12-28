console.log("#question-<%=@question.slug%>");
var $question = $("#question-<%=@question.slug%>");
$("body").append("<%= j (render partial: 'shared/notification', locals: {message: 'Question Deleted'} )%>");
$("#notification").fadeIn(1000);
$("#notification").fadeOut(1000);

$question.fadeOut();
$question.remove();