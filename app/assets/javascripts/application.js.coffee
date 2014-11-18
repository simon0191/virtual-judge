# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require trunk8
#= require bootstrap-sprockets
#= require jquery_ujs
#= require turbolinks
#= require_tree .

configTrunk8 = ->

  $('[data-trunkeight]').trunk8
    fill: '<a class="read-more" href="#">&hellip; ver más</a>'
    lines: 3


  $('[data-trunkeight]').on 'click','.read-more', (event)->
    $(@).parent()
      .trunk8('revert')
      .append(' <a class="read-less" href="#">ver menos</a>')
    false

  $('[data-trunkeight]').on 'click','.read-less', (event)->
    $(@).parent().trunk8()
    false

ready = ->
  configTrunk8()

$(document).ready(ready)
$(document).on('page:load', ready)

