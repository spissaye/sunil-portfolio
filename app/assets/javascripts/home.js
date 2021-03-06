// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  "use strict";

  $(".exp-title").on("click", function () {
    let target_ele = $($(this).data("target"));
    target_ele.modal();
  });

  var window_width   = $(window).width(),
  window_height      = window.innerHeight,
  header_height      = $(".default-header").height(),
  header_height_static = $(".site-header.static").outerHeight(),
  fitscreen        = window_height - header_height;


  $(".fullscreen").css("height", window_height)
  $(".fitscreen").css("height", fitscreen);

  //-------- Active Sticky Js ----------//
  $(".default-header").sticky({topSpacing:0});

      // Select all links with hashes
  $('a[href*="#"][class*="scroll-nav"]')
    // Remove links that don't actually link to anything
    .not('[href="#"]')
    .not('[href="#0"]')
    .on('click',function(event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
      &&
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top-50
        }, 1000, function() {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });

  $(document).on("ajax:success", "#contact_form", function(event, data, status, xhr) {
    $("#contact_form").slideUp(function(){
      $(".contact-error").fadeOut();
      $(".contact-thank-you").fadeIn();
    });
  });

  $(document).on("ajax:error", "#contact_form", function(event) {
    if (event.detail[0]["base"] != null) {
      $(".contact-captcha-error").text(event.detail[0]["base"]).fadeIn();
    } else {
      $(".contact-error").fadeIn();
    }
  });
});