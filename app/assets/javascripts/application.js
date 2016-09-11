// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require chosen-jquery
//= require bootstrap-sprockets
//= require_tree .
$(document).ready(function() {
    $("#home-slideshow").carousel({
        interval: 2500,
        pause: false
    });

    $(window).keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            $("form").submit();
        }
        console.log(event.which);
    });

    $('#search').click(function() {
        $('#search-wrapper').toggleClass('moved');
    })
})
