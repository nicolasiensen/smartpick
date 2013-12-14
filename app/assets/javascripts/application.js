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
//= require modernizr
//= require foundation
//= require jquery.cookie
//= require Chart
//= require_tree .

$(function(){
  $(document).foundation();
});

$(window).load(function(){
  var data = {labels:["January","February","March","April","May","June","July"],datasets:[{fillColor:"rgba(220,220,220,0.5)",strokeColor:"rgba(220,220,220,1)",pointColor:"rgba(220,220,220,1)",pointStrokeColor:"#fff",data:[65,59,90,81,56,55,40]},{fillColor:"rgba(151,187,205,0.5)",strokeColor:"rgba(151,187,205,1)",pointColor:"rgba(151,187,205,1)",pointStrokeColor:"#fff",data:[28,48,40,19,96,27,100]}]}

  var ctx = $("#myChart").get(0).getContext("2d");
  var container = $("#myChart").parent();
  $(window).resize( generateChart );  

  function generateChart(){
    var ww = $("#myChart").attr('width', $(container).width() );
    new Chart(ctx).Line(data, {});
  };

  generateChart();
});
