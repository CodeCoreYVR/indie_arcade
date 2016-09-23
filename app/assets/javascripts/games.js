$(document).ready(function(){
// COLOR STYLING OF GAME STATUS'
   var panel = $('.container').find('.panel-result');
   panel.each(function(i){
     setTimeout(function(){
       $('.panel-result').eq(i).addClass('is-visible');
     }, 200 * i);
   });


  // $('.game-status').each(function(){
  //   if ($(this).html() == "Game under review") {
  //     $(this).css({'color': 'blue'});
  //   }
  //   else if ($(this).html() == "Game not uploaded") {
  //     $(this).css({'color': 'red'});
  //   }
  //   else if ($(this).html() == "Rejected") {
  //     $(this).css({'color': 'red'});
  //   }
  // });
});
