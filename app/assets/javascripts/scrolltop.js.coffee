ready = ->
  $(window).scroll ->
    element = $('#page-top-btn')
    element_blog = $('#blogpage-top-btn')
    visible = element.is(':visible')
    height = $(window).scrollTop()
    if height > 400
      element.fadeIn() if !visible
    else if height > 200
      element_blog.fadeIn() if !visible  # body...
    else
      element.fadeOut()
      element_blog.fadeOut()
  $(document).on 'click', '#move-page-top', ->
    $('html, body').animate({ scrollTop: 0 }, 'slow')

$(document).ready(ready)
$(document).on('page:load', ready)
