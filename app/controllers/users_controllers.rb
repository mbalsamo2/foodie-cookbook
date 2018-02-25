class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :"/users/signup"
    else
      redirect to "/recipes"
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
      flash[:message] = "You successfully logged out!"
      redirect to "/login"
    else
      flash[:message] = "You must be logged in to log out!"
      redirect to "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    verify_user
    erb :"/users/show"
  end

  post '/signup' do
    if params[:name] != "" && params[:password] != "" && User.find_by_name(params[:name]).nil?
      @user = User.create(params)
      session[:user_id] = @user.id
      flash[:message] = "Successfully created an account!"
      redirect to "/recipes"
    else
      flash[:message] = "You must have a name and password to create an account. If both are filled, this account name already exists."
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
      flash[:message] = "Successfully logged in!"
      redirect to "/recipes"
    else
      flash[:message] = "You entered the wrong password. Please try again so you can get cookin'!"
      redirect to "/login"
    end
  end

end
