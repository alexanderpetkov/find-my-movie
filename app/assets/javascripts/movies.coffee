document.addEventListener 'turbolinks:load', ->
  $('.movie-input').keyup (e) ->
    if e.keyCode != 13
      q = $(this).val()

      if q.length == 0
        $('.suggestions').hide()
      else
        $.get 'search/movie_suggestions', {q: q}
        $('.suggestions').show()

  $(window).click ->
    $('.suggestions').hide()

  $('.movie-input').click (e) ->
    e.stopPropagation()
    $('.suggestions').show()

  $('.load-more').click (e) ->
    q = $('.movie-input').val()
    $.get 'search/movies', {q: q, offset: $movies.length}
