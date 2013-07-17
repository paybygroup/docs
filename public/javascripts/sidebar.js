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

  $("a[href^='info#']").hover(function() {
    var name_of_id = $(this).attr('href').replace('info', '');
    var new_element = $(name_of_id).clone();
    var height_of_element = $(this).offset().top - 126;
    new_element.addClass("to_delete");
    new_element.css({
      "position":"absolute",
      "top": height_of_element
    })
    new_element.appendTo("#js-sidebar");
    new_element.css("top", height_of_element - new_element.height()/2 - $(this).parent().height()/2)
  }, function() {
    $(".to_delete").remove()
  })


});
