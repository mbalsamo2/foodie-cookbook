class RecipesController < ApplicationController

  use Rack::Flash

  get '/recipes' do
    @user = User.find_by_id(session[:user_id])
    @recipes = Recipe.all
    erb :"/recipes/recipes"
  end

  get '/recipes/new' do
    erb :"/recipes/create_recipe"
  end

  get '/recipes/:id' do
    erb :"/recipes/show_recipe"
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    @recipe.user_id = session[:user_id]

    redirect to "/recipes/#{@recipe.id}"
  end

end
