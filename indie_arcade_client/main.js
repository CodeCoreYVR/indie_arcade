$(document).ready( function() {
  var currentGames = new_games();

  $("#get-new-games").click(function(e) {
    e.preventDefault();
    currentGames = new_games();
  });
});

var new_games = function() {
  $.get("http:/localhost:3000/games.json", function(data){
    console.log(data);
    $('#games-list').children().remove();
    for (i in data) {
      var template = $("#game-listing-tmpl").html();
      var renderedHTML = Mustache.render(template, data[i]);
      $('#games-list').append( renderedHTML );
    }
    return data;
  });
};
