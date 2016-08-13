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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootsy
//= require_tree .


$(document).on("click", ".choice_radio_button", function(e) {
  $(e.target).parent().parent().parent().find(".choice_body").removeClass("selected_choice");
  $(e.target).parent().parent().find(".choice_body").toggleClass("selected_choice")
});

$(document).on("click", "#find_vocabulary_word_api_search_button", function() {
  var api_key = $("#api_key").val();
  var search_term = $("#vocabulary_word_main").val()
  url = "http://api.pearson.com/v2/dictionaries/entries?headword=+" + search_term + "&apikey=" + api_key
  console.log(url)
  $.ajax({
    url: url,
  })
  .done(function(data ) {
    console.log(data.results);
    var output = "<ol>";
    for(var i = 0; i < data.results.length; i++) {
      var result = data.results[i]; 
      var html = 
      "<br><li>" +
      "word: " + result.headword + "<br>" +
      "part of speech: " + result.part_of_speech + "<br>" +
      "definition: " + result["senses"][0]["definition"] + "</li>";
      output = output + html
    }
    output = output + "</ol>"
    $("#word_search_api_results").html(output)
  })
  .fail(function() {
    console.log("error");
  });
  
});


