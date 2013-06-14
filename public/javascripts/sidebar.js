// Init sidebar
$(function() {

  $('.js-guides a').click( function(e) {
    e.preventDefault();
    var height = $("h4:contains('" + this.text + "')").offset().top;
    $("body").scrollTop(height);
  })


  // Dynamic year for footer copyright
  var currentYear = (new Date).getFullYear();
  $("#year").text( (new Date).getFullYear() );

  // Grab API status
  // $.getJSON('https://status.github.com/api/status.json?callback=?', function(data) {
  //   if(data) {
  //     var link = $("<a>")
  //       .attr("href", "https://status.github.com")
  //       .addClass(data.status)
  //       .attr("title", "API Status: " + data.status + ". Click for details.")
  //       .text("Status: " + data.status);
  //     var img = $("<img>")
  //       .attr("src", "/images/status-icon-" + data.status + ".png")
  //       .height(16)
  //       .width(16);
  //     link.append(img);
  //     $('.api-status').html(link);
  //   }
  // });

});
