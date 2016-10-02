$ ->
  $('.movie-input').keyup (e) ->
    q = $(this).val()
    $.get("search/movie_suggestions?q=#{q}")
    $('.suggestions').show()

  $(window).click ->
    $('.suggestions').hide()

  $('.movie-input').click (e) ->
    e.stopPropagation();
    $('.suggestions').show()
