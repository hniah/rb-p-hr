$(document).on('ready page:load', function() {
  $('a.add_new_form').click(function(e){
    e.preventDefault();
    $('tr.add-new-setting').show()
    $('a.add_new_form').hide()
  });

  $('a.cancel_form').click(function(e){
    e.preventDefault();
    $('tr.add-new-setting').hide()
    $('a.add_new_form').show()
  });
})
