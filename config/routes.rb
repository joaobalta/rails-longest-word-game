Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end

# In the end, rails routes should return something like this:

# Prefix Verb URI Pattern      Controller#Action
#    new GET  /new(.:format)   games#new
#  score POST /score(.:format) games#score

# Generic syntax:#
#  verb  'path', to: 'controller#action'
# get    'ask', to: 'questions#ask'
