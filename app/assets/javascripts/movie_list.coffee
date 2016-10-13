document.addEventListener 'turbolinks:load', ->
  $('body').on 'click', '.load-more', ->
    q = $('.movie-input').val()
    $.get 'search/movies', {q: q, offset: $movies.length}
