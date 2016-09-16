Rails.application.routes.draw do
  get '/' => 'public#welcome'
  get 'search/movies' => 'search#movies'

  resources :movies, only: :show
end
