$(document).ready( function() {
  $.get("http:/localhost:3000/games.json", function(data){
    for (i in data) {
      var template = $("#game-listing-tmpl").html();
      var renderedHTML = Mustache.render(template, data[i]);
      $('#games').append( renderedHTML );
    }
  });
});
