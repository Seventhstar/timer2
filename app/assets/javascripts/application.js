// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.toolbar
//= require spin
//= require jquery.spin
//= require nprogress
//= require_tree .

var showNotifications = function(){ 
  $nt = $(".alert"); 
  
  //setTimeout(function() {$nt.addClass("in");}, 1000);
  setTimeout(function() {$nt.removeClass("in").addClass('out');}, 4000);
}

var show_ajax_message = function(msg, type) {
    if (!type) {type = "success"};
    $(".js-notes").html( '<div class="alert fade-in flash_'+type+'">'+msg+'</div>');    
    showNotifications();
};

$( document ).ready(function() {
    showNotifications();
});


var toggle_details = function(){
  $('span.plus').click(function(){
    
    id = $(this).attr('id').substr(5);
      //$('.children-'+id).slideToggle('slow');
      $('.children-'+id).toggle('slow'); 
     
    if($('#span-'+id).hasClass('opened')) {
     
      $('#span-'+id).removeClass('opened');
      $('#span-'+id).text('-');
      
    } else {
        
     $('#span-'+id).text('+');
      $('#span-'+id).addClass('opened');
      
    }
  })
};

var add_timer_function = function(){

  $('.otdel').stopwatch().click( function(){ 
      $(this).stopwatch('toggle','#demo2');


      if ($(this).attr("started")==0){
         $.ajax({
           url: "/ajax/save_last_time",
           data: {'otdel':$(this).attr("otdel_id"),
                  'last_time':$(this).attr("last_time"), 
                  'ut_type_id':$('.btn.active').attr("type_id"),
                  'task_id': $(".task.active").attr('task_id') //$('#task_id_').attr('task_id')
                },
           type: "POST",
           beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},   
           success: function(){
            $("#table_seconds").load("used_times #table_seconds > *",toggle_details);
            } 
         });
      };
    
  });

};


$(function() {

  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 300
  });

  NProgress.start();
  NProgress.done();

  $( document ).ajaxStop(function() {
      NProgress.start();
  });  
  $( document ).ajaxStop(function() {
    $('table.tableSorter').tableSort();
    NProgress.done();
  });

  $('table.tableSorter').tableSort();
  $('.datepicker').datetimepicker({step:5});

  $('#lay_el_element_id').chosen();
  $('#wh_el_element_id').chosen();


  $('.options-menu a').click(function(){ 
      $('.options-menu a.active').removeClass("active", 550, "easeInQuint");
      $(this).addClass("active");
      var url = "/" + $(this).attr("controller");
      $.get(url, null, null, "script");
      if (url!="/undefined") setLoc("options"+url);
  });


  $(document).on('click','#btn-send',function(e) {  
    
    var valuesToSubmit = $('form').serialize();
    var values = $('form').serialize();
    var url = $('form').attr('action');
    var empty_name = false;
    each(q2ajx(values), function(i, a) {
      if (i.indexOf("[name]") >0  && a=="" ) { empty_name = true; return false; }
    });

    if (!empty_name){
      $.ajax({
          type: "POST",
          url: url, //sumbits it to the given url of the form
          data: valuesToSubmit,
          dataType: 'JSON',  
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},         
          success: function(){$.get(url, null, null, "script"); $('input[name*=name]').val('');}
      });
    }
  });

  add_timer_function();
  toggle_details();
  
  $('.btn.new_otdel').click( 
   function(){ 
   
   //alert($("#otdel_errors").text());
   name_o = $('#name_otdel').val(); 
   if (name_o.length) 
      $.ajax({
      	 url: "/ajax/save_new_otdel",
      	 data: {'otdel_name':name_o},
      	 type: "POST",
      	 beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},	 
      	 success: function(data, textStatus, jqXHR){
             $('#errormessage').load("used_times #errormessage > *");
             fade_flash(); 
             $("#otdels_list").load("used_times #otdels_list > *",add_timer_function);             
             $("#name_otdel").val("");             
           },
         error: function (data, textStatus, jqXHR) { $("#otdel_errors").text(jqXHR); }
      });

   });

  $('.btn.new_task').click( 
   function(){ 
   
   //alert($("#otdel_errors").text());
   name_t = $('#name_task').val(); 
   if (name_t.length) 
      $.ajax({
         url: "/ajax/save_new_task",
         data: {'task_name':name_t},
         type: "POST",
         beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},   
         success: function(data, textStatus, jqXHR){
             $('#errormessage').load("used_times #errormessage > *");
             fade_flash(); 
             $("#tasks_list").load("used_times #tasks_list > *");             
             $("#name_task").val("");             

           },
         error: function (data, textStatus, jqXHR) { $("#otdel_errors").text(jqXHR); }
      });

   });


});

    
