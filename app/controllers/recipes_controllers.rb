class RecipesController < ApplicationController

    use Rack::Flash

  get '/recipes' do
    @user = User.find_by_id(session[:user_id])
    @recipes = Recipe.all
    erb :"/recipes/recipes"
  end

end
