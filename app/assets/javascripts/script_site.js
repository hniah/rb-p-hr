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

  $( "#leave_start_date" ).datepicker({
    changeMonth: true,
    numberOfMonths: 1,
    dateFormat: 'dd/mm/yy',
    minDate: 0,
    onClose: function( selectedDate ) {
      $( "#leave_end_date" ).datepicker( "option", "minDate", selectedDate );
    }
  });
  $( "#leave_end_date" ).datepicker({
    changeMonth: true,
    numberOfMonths: 1,
    dateFormat: 'dd/mm/yy'
  });

})
