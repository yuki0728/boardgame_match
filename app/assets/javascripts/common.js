$(document).on('turbolinks:load', function(){
  $('.datepicker').datetimepicker({
    format : "YYYY/MM/DD"
  });
  $('.datetimepicker').datetimepicker({
    format : "YYYY/MM/DD HH:mm"
  });
});

$(function(){
  setTimeout("$('.time-limit').fadeOut('slow')", 3000) 
})