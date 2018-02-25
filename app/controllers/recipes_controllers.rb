class RecipesController < ApplicationController

  use Rack::Flash

  get '/recipes' do
    @user = User.find_by_id(session[:user_id])
    verify_user
    @recipes = Recipe.all
    erb :"/recipes/recipes"
  end

  get '/recipes/new' do
    if verify_user
      erb :"/recipes/create_recipe"
    else
      flash[:message] = "Please log in to your account to do this."
      redirect to "/logout"
    end
  end

  get '/recipes/:id' do
    verify_user
    @recipe = Recipe.find_by_id(params[:id])

    erb :"/recipes/show_recipe"
  end

  get '/recipes/:id/edit' do
    if verify_user
      @recipe = Recipe.find_by_id(params[:id])
      erb :"/recipes/edit_recipe"
    else
      flash[:message] = "Please log in to your account to do this."
      redirect to "/logout"
    end
  end

  get '/recipes/:id/delete' do
    if verify_user
      @recipe = Recipe.find_by_id(params[:id])
      erb :"/recipes/delete_recipe"
    else
      flash[:message] = "Please log in to your account to do this."
      redirect to "/logout"
    end
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

  patch '/recipes/:id' do
    if params[:recipe_name] == "" || params[:ingredients] == "" || params[:instructions] == ""
      redirect to "/recipes/#{params[:id]}/edit"
    else
      @recipe = Recipe.find_by_id(params[:id])
      verify_user
      @recipe.update(recipe_name: params[:recipe_name], cook_time: params[:cook_time], ingredients: params[:ingredients], instructions: params[:instructions])
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  delete '/recipes/:id/delete' do
    if verify_user
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.delete
      redirect to "/recipes"
    else
      flash[:message] = "Please log in to your account to do this."
      redirect to "/logout"
    end
  end

end
