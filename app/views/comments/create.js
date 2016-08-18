$("#comment_body").val("")
console.log("Comment saved!")
var $comments =  $("#comments")
console.log($comments)
$comments.prepend("<%= j (render partial: 'comment', locals: { comment: @comment, commentable_type: @comment.commentable_type  } ) %>");
