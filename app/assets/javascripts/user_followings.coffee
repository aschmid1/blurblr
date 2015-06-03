# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Toggle unfollow button on mouse hover
$(document).on "ready page:change", ->
  $('.js-unfollow-button').hover(->
    $(@).removeClass('btn-success').addClass('btn-danger')
    $(@).find('.glyphicon').removeClass('glyphicon-check').addClass('glyphicon-remove')
    $(@).find('.btn-text').text("Unfollow")
  ->
    $(@).removeClass('btn-danger').addClass('btn-success')
    $(@).find('.glyphicon').removeClass('glyphicon-remove').addClass('glyphicon-check')
    $(@).find('.btn-text').text("Following")
  )
