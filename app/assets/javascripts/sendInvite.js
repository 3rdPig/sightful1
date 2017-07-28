$('.btn-schedule').click(function () {
  console.log('sending');
  
  // TODO: Validate form
  var from = $('.from').val();
  var to = $('.to').val();
  var topic = $('.topic').val();
  var stamp = new Date();
  var ref = to + '-' + from + '-' + stamp;
  for (var i = 0; i < 3; i++) {
    var date;
    var time;
    if (i == 0) {
      date = $('.date1').val();
      time = $('.time1').val();
    } else if (i == 1) {
      date = $('.date2').val();
      time = $('.time2').val();
    } else if (i == 2) {
      date = $('.date3').val();
      time = $('.time3').val();
    }

    $.ajax({
      type: 'POST',
      url: '/api/add_invitation',
      data: { from: from, to: to, topic: topic, date: date, time: time, ref: ref },
      beforeSend: function () {
        $('#ajax-panel').html('<div class="loading"><img src="/images/squares.svg" alt="Loading..." /></div>');
      },

      success: function (data) {
        $('#ajax-panel').empty();
        console.log(data);

        // TODO: Display success modal
      },

      error: function () {
        $('#ajax-panel').html('<p class="error"><strong>Oops!</strong> Try that again in a few moments.</p>');

      },

    });
  }
});
