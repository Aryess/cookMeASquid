# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  s = $("input#serving")
  vs = s.val()
  s.after "<output id='s_serving'>Any</output>"
  s.on "change", ->
    valof = $(this).val()
    valof = "Any"  if valof is "0"
    $("output#s_serving").text valof

  d = $("input#diff")
  vd = d.val()
  d.after "<output id='s_diff'>d</output>"
  $("output#s_diff").text vd
  d.on "change", ->
    valof = $(this).val()
    $("output#s_diff").text valof