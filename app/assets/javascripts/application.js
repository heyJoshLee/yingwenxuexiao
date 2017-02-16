// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootsy
//= require_tree .

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-39639798-7', 'auto');
ga('send', 'pageview');

$(document).on("click", ".vocab_tool_tip_launcher", function(e) {
  e.preventDefault();
  $(this).next().fadeToggle();
});

$(document).on("click", ".vocab_speach_button", function(e) {
  console.log("clicked");
  console.log($(this).attr("data-word"));
  var word_to_say = $(this).attr("data-word");
  var msg = new SpeechSynthesisUtterance(word_to_say);
  window.speechSynthesis.speak(msg);
});

$(document).on("click", ".choice_radio_button", function(e) {
  $(e.target).parent().parent().parent().find(".choice_body").removeClass("selected_choice");
  $(e.target).parent().parent().find(".choice_body").toggleClass("selected_choice")
});


$(document).on("click", "#start_talking", function() {
  var recognition = new webkitSpeechRecognition();

  recognition.continuous = false;
  recognition.interimResults = false;

  recognition.lang = "en-US";
  
  recognition.start();

  recognition.onstart = function() {
    console.log("starting")
  }

  recognition.onresult = function(e) {
    console.log(e.results[0][0].transcript)

    console.log("result");

    recognition.stop();
  }

  recognition.onerror = function(e) {
    recognition.stop();
  }
});

$(document).on("click", ".comment_reply_launcher", function(e) {
  var $form = $(e.target).next(".row").find(".comment_reply_form");
  $form.toggle();
});

$(document).on("click", ".membership_level_choice_div", function(e) {
  console.log("click");
  var $target = $(e.target);
  console.log($target.next("input"))
  $target.next("input").click();
});

$(document).on("click", "#close_level_up_container", function(e) {
  var $level_up_container = $("#level_up_container");
  $level_up_container.fadeOut("slow", function() {
    $level_up_container.remove();
  });
});

$(document).on("keyup", "#new_vocabulary_word", "#vocabulary_word_main", function(e) {
  $.ajax({
    url: "/admin/dashboard/vocabulary_words/get_related_words",
    method: "POST",
    data: {
      search_query: $("#add_vocabulary_word_main").val(),
      lesson_id: $("#vocabulary_wordable_id").val()
    }
  });
});


// jQuery UI

$(function() {
    // $("#sortable_lessons").sortable({

  $(".sortable_lessons").sortable({
    axis: "y",
    update: function() {
      $("#saving").fadeIn();
      $.post($(this).data("update-url"), $(this).sortable("serialize")).done(function() {
        $("#saving").fadeOut();
      })
    }
  });

    $( ".accordion" ).accordion({
      collapsible: true,
      heightStyle: "content",
      active: false
    });
});



// practice



$(document).on("click", ".flash_card_study_option_button", function(e) {
    $(".flash_card_study_option_button").removeClass("checked");
    $(e.target).addClass("checked");
  });



// $(document).on("click", "#find_vocabulary_word_api_search_button", function() {
//   var api_key = $("#api_key").val();
//   var search_term = $("#vocabulary_word_main").val()
//   url = "http://api.pearson.com/v2/dictionaries/entries?headword=+" + search_term + "&apikey=" + api_key
//   console.log(url)
//   $.ajax({
//     url: url,
//   })
//   .done(function(data ) {
//     console.log(data.results);
//     var output = "<ol>";
//     for(var i = 0; i < data.results.length; i++) {
//       var result = data.results[i]; 
//       var html = 
//       "<br><li>" +
//       "word: " + result.headword + "<br>" +
//       "part of speech: " + result.part_of_speech + "<br>" +
//       "definition: " + result["senses"][0]["definition"] + "</li>";
//       output = output + html
//     }
//     output = output + "</ol>"
//     $("#word_search_api_results").html(output)
//   })
//   .fail(function() {
//     console.log("error");
//   })
// });



