# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).on('load resize ', ->
  scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width()
  $('.tbl-header').css 'padding-right': scrollWidth
  return
).resize()