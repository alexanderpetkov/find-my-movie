$ ->
  $('.movie-input').keyup (e) ->
    q = $(this).val()
    $.get("search/movie_suggestions?q=#{q}")
    $('.suggestions').show()

  $(window).click ->
    $('.suggestions').hide()
