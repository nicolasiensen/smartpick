// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require autocomplete-rails
//= require turbolinks
//= require foundation
//= require jquery.cookie
//= require_tree .

$(function(){
  $(document).foundation();
});

$(window).load(function(){
  $(document).foundation('joyride', 'start');
  $('#model_id_1').focus(function(){ $('.joyride-tip-guide[data-index="0"] a.joyride-next-tip').trigger('click'); });
  $('#model_id_2').focus(function(){ $('.joyride-tip-guide[data-index="1"] a.joyride-next-tip').trigger('click'); });
  $('#compare_button').focus(function(){ $('.joyride-tip-guide[data-index="2"] a.joyride-next-tip').trigger('click'); });
});
