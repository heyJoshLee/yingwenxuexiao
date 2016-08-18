$("#reply-<%=@comment.slug%>").val("");
$("#reply_form_<%=@comment.slug%>").hide();
$("#comment-<%=@comment.slug%> .replies").prepend("<%= j (render partial: 'reply', locals: { reply: @reply } ) %>");

