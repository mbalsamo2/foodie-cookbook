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
    @user = User.find_by_id(session[:user_id])
    verify_user
    erb :"/recipes/show_recipe"
  end

  post '/recipes' do
    if params[:recipe_name] == "" || params[:ingredients] == "" || params[:instructions] == ""
      redirect to "/recipes/new"
    else
      @recipe = Recipe.new(params)
      @recipe.user_id = session[:user_id]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
  end
  end

end
