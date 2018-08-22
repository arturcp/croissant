$(document).ready(function() {
  var showAnswers = $('[data-check-answers]');

  if (showAnswers.length > 0) {
    showAnswers.on('click', function() {
      var inputs = $('[data-conjugation-fields] input');
      $.each(inputs, function() {
        var input = $(this),
            response = input.parent().next();

        response.removeClass('hide');
      });
      showAnswers.hide();
    });
  }
});
