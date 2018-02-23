class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :"/users/signup"
    else
      rredirect to "/recipes"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/recipes"
    end
  end

  get '/logout' do
    if logged_in?
      logout!
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    verify_user
    erb :"/users/show"
  end

  post '/signup' do
    if params[:name] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "/recipes"
    else
      flash[:message] = "You must have a name and password to create an account."
      redirect to "/signup"
    end
  end

  post '/login' do
    @user = User.find_by(name: params[:name])
    if !@user
      flash[:message] = "Could not find an account with that chef information."
      redirect to "/login"
    elsif @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/recipes"
    else
      flash[:message] = "You entered the wrong password. Please try again so you can get cookin'!"
      redirect to "/login"
    end
  end

end
