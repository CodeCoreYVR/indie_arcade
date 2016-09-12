$(document).ready( function() {
  var currentGames;

  $.get("http:/localhost:3000/games.json", function(data){
    currentGames = data;
    console.log(data);
    // for (i in data) {
    //   var template = $("#game-listing-tmpl").html();
    //   var renderedHTML = Mustache.render(template, data[i]);
    //   $('#games').append( renderedHTML );
    // }
  });

  $("#play-game").click(function() {
    console.log("Clicked Play");
    var random = Math.floor(Math.random() * (currentGames.length - 1 + 1)) + 1;

    var template = $("#game-listing-tmpl").html();
    var renderedHTML = Mustache.render(template, currentGames[random]);
    $('#games').children().remove();
    $('#games').append( renderedHTML );
  });


});
