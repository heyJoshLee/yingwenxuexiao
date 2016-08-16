var $marks = $("#correct_and_incorrect_marks");
var $correct = $("#correct");
var $incorrect = $("#incorrect");

$correct.hide();
$incorrect.hide();

if ("<%= @correct %>") {
  console.log("Correct!")
  $correct.show();
} else {
  console.log("WRONG!")
  $incorrect.show();
}

$marks.fadeIn(1000, function() {
  $marks.fadeOut(1000);
});

$("#play_area_container").html("<%= j (render partial: 'play_area', locals: { word: @word, choices: @choices, study: @study }) %>")
$("#current_user_points").html("<%= @user.points %> points");
$("#current_user_level").html("<%= @user.level %>");
