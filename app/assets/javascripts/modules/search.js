$(document).ready(function() {
  var searchButton = $('#search-button');

  if (searchButton.length > 0) {
    var input = $('#search');
    input.on('keyup', function(e) {
      if(e.keyCode == 13) {
        searchButton.trigger('click');
      }
    });

    searchButton.on('click', function() {
      var verb = input.val();

      if (verb.length > 0) {
        location.href = searchButton.attr('data-url') + '/' +  verb;
      }
    });
  }
});
