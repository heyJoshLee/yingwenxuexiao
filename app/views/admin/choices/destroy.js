var $element = $("#choice-<%=@choice.id%>");
$element.fadeOut();
$element.remove();
$("body").append("<%= j (render partial: 'shared/notification', locals: {message: 'Question Deleted'} )%>");
$("#notification").fadeIn(1000);
$("#notification").fadeOut(1000);
