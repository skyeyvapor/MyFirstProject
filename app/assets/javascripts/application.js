// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require modernizr-2.8.3
//= require jquery
//= require jquery_ujs
//要把這行也註解掉不然會有問題不能留下＝ turbolinks
//= require_tree .

//js產生的動畫的部分放在這
//A controversial features of Rails4.0的turbolink新功能(pre-fetching of elements that changing in the page to make page transistions smoother)
//，會偷偷按一下按鈕翻新整個頁面，造成此處js異常，可把layouts/application.html.erb裡的turbolinks刪除
//$ notation for jQuery
$(function() { //invoke that non-ready/anoymous function when the html dump has been passed
	$( "#comments" ).hide(); //#字號是css selector //jQuery hide method //一開始就先hide
	$( "#show_comments").click(function() { //bind a function to a button //加入show button的功能
		$( "#comments" ).slideDown(); //一按comment內容就slidedown
		$( this ).hide('normal'); //接著這show按鈕不見，速度normal
	});
	$( "#hide_comments").click(function() {
		$( "#comments" ).slideUp();
		$( "#show_comments" ).show('normal'); //當我們按下hide button時，要叫出show comment button
	});
})