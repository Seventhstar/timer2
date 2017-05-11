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
      $('.children-'+id).toggle('fast'); 
     
    if($('#span-'+id).hasClass('opened')) {     
      $('#span-'+id).removeClass('opened');
      $('#span-'+id).text('+');      
    } else {        
      $('#span-'+id).text('-');
      $('#span-'+id).addClass('opened');      
    }
    op = $('.opened').map(function() {return $( this ).attr('id').substr(5);}).get().join();
    setLoc('used_times?op='+op.toString());
  });  
};

var add_timer_function = function(){

  // $(".table-striped").tableDnD();
  $('.table-striped').tableDnD({
         onDrop: function(table, row) {
             alert($.tableDnD.serialize());
         }        
    });

    $(".table-striped tr").hover(function() {
          $(this.cells[0]).addClass('showDragHandle');
    }, function() {
          $(this.cells[0]).removeClass('showDragHandle');
    });
  // $('#table-5').tableDnD({
  //       onDrop: function(table, row) {
  //           alert($.tableDnD.serialize());
  //       },
  //       dragHandle: ".dragHandle"
  //   });

  $('.otdel').stopwatch().click( function(){
      cur_btn = $('.started');
      if (cur_btn.attr("started")==1){
          cur_btn.stopwatch('toggle','#demo2');  
          cur_btn.toggleClass('started active');
         $.ajax({
           url: "/ajax/save_last_time",
           data: {'otdel': cur_btn.attr("otdel_id"),
                  'last_time':cur_btn.attr("last_time"), 
                  'ut_type_id':$('.btn.active').attr("type_id"),
                  'task_id': $(".task.active").attr('task_id') //$('#task_id_').attr('task_id')
                },
           type: "POST",
           beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},   
           success: function(){
            op = $('.opened').map(function() {return $( this ).attr('id').substr(5);}).get().join();
            $("#table_seconds").load("used_times?op="+op+" #table_seconds > *",toggle_details);
          } 

         });
      };
      if ($(this).attr('otdel_id')!=cur_btn.attr('otdel_id')){
        $(this).stopwatch('toggle','#demo2');
        $(this).toggleClass('started active');
      }

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

  var accordion_head = $('.accordion > li > a'),
    accordion_body = $('.accordion li > .sub-menu');

  // Open the first tab on load
  accordion_head.first().addClass('active').next().slideDown('normal');

  accordion_head.on('click', function(event) {
    event.preventDefault();

    if ($(this).attr('class') != 'active'){
      accordion_body.slideUp('normal');
      $(this).next().stop(true,true).slideToggle('normal');
      accordion_head.removeClass('active');
      $(this).addClass('active');
    }

  });

  $(document).on('click','.itemAdd_form #btn-send',function(e) {  
    
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


  $( document ).ajaxStart(function() {
      NProgress.start();
  });  
  $( document ).ajaxStop(function() {
    $('table.tableSorter').tableSort();
    NProgress.done();
    $('.datepicker').datetimepicker({step:5});
  });

  $('table.tableSorter').tableSort();
  $('.datepicker').datetimepicker({step:5});

  $('#lay_el_element_id').chosen();
  $('#wh_el_element_id').chosen();
  $('#goal_user_id').chosen();


  // $('.options-menu a').click(function(){ 
  //     $('.options-menu a.active').removeClass("active", 550, "easeInQuint");
  //     $(this).addClass("active");
  //     var url = "/" + $(this).attr("controller");
  //     show_ajax_message(url);
  //     $.get(url, null, null, "script");
  //     if (url!="/undefined") setLoc("options"+url);
  // });



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
             //fade_flash(); 
             $("#otdels_list").load("used_times #otdels_list > *",add_timer_function);             
             $("#name_otdel").val("");             
           },
         error: function (data, textStatus, jqXHR) { $("#otdel_errors").text(jqXHR); }
      });

   });

  $('body').on('keyup keypress', '.simple_options_form', function(e) {
    var code;
    code = e.keyCode || e.which;
    if (code === 13) {
      e.preventDefault();
      if (e.type === 'keyup') {
        $('#btn-send').trigger('click');
        return;
      }
      return false;
    }
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
             //fade_flash(); 
             $("#tasks_list").load("used_times #tasks_list > *");             
             $("#name_task").val("");             

           },
         error: function (data, textStatus, jqXHR) { $("#otdel_errors").text(jqXHR); }
      });

   });


});

    
