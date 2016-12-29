$("#comment_body").val("")
var $comments =  $("#comments")
$comments.prepend("<%= j (render partial: 'comment', locals: { comment: @comment, commentable_type: @comment.commentable_type  } ) %>");
