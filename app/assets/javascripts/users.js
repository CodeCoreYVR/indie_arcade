$(function() {
  var $realInputField;
  $realInputField = $('#user_logo');

  $realInputField.change(function() {
    return $('#file-display').val($(this).val().replace(/^.*[\\\/]/, ''));
  });

  $('#upload-btn').click(function() {
    return $realInputField.click();
  });
});
