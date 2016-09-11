$(document).ready( function() {
  $.get("http:/localhost:3000/questions.json", function(data){
    for (i in data) {
      var template = $("#question-listing-tmpl").html();
      // Call render with templateHTML and JS Object as args
      // Replaces mustache-wrapped entries with values of
      // JS object.
      // eg. "{{title}}" with "object.title"
      var renderedHTML = Mustache.render(template, data[i]);
      $('#questions').append( renderedHTML );
    }
  });
});
