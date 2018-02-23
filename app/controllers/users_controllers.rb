class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    erb :"/users/signup"
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
