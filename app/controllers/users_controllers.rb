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

end
