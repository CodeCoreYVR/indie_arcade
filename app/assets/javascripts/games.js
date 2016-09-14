$(document).ready(function(){
// COLOR STYLING OF GAME STATUS'

  $('.game-status').each(function(){
    if ($(this).html() == "Game under review") {
      $(this).css({'color': 'blue'});
    }
    else if ($(this).html() == "Game not uploaded") {
      $(this).css({'color': 'red'});
    }
    else if ($(this).html() == "Rejected") {
      $(this).css({'color': 'red'});
    }
  });
});
