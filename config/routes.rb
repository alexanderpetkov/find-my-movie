Rails.application.routes.draw do
  get '/' => 'public#welcome'
  get 'search/movies' => 'search#movies'
  get 'search/movie_suggestions' => 'search#movie_suggestions'

  resources :movies, only: :show
end
