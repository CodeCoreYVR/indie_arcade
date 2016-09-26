$(document).ready(function(){
// COLOR STYLING OF GAME STATUS'
   var panel = $('.container').find('.panel-result');
   panel.each(function(i){
     setTimeout(function(){
       $('.panel-result').eq(i).addClass('is-visible');
     }, 200 * i);
   });
});
