// Init sidebar
$(function() {

  $('.js-guides a').click( function(e) {
    e.preventDefault();
    var height = $("h2:contains('" + this.text + "')").offset().top;
    $("body").scrollTop(height);
  })

  // Dynamic year for footer copyright
  var currentYear = (new Date).getFullYear();
  $("#year").text( (new Date).getFullYear() );

});
