console.log("#choice-container-<%=@choice.id%>")

var $element = $("#choice-container-<%=@choice.id%>");
$element.html("<%= j (render partial: 'admin/quizzes/choice', locals: {choice: @choice, question: @question, lesson: @lesson, course: @course} )%>");




