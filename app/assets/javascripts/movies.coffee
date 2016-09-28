$ ->
  $('.movie-input').keydown (e) ->
    q = $(this).val()
    $.get("search/movie_suggestions?q=#{q}")
