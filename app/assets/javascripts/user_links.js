$.UserLinks = {
  setupOpen: function() {
    $('[data-popup-open]').on('click', function(e) {
      e.preventDefault();
      var fadeInTarget = e.target.dataset.popupOpen;
      $('[data-popup="' + fadeInTarget + '"]').fadeIn(350);
    });
  },

  setupClose: function() {
    $('[data-popup-close]').on('click', function(e) {
      e.preventDefault();
      var fadeOutTarget = e.target.dataset.popupClose;
      $('[data-popup="' + fadeOutTarget + '"]').fadeOut(350);
    });
  },

  init: function() {
    this.setupOpen();
    this.setupClose();
  }
};

$(function() {
  $(document).ready (function() {
    $.UserLinks.init();
  });
});
