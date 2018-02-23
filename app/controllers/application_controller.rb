class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "cookit"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  helpers do

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def verify_user
      if logged_in?
        @current_user = current_user
      else
        flash[:message] = "Please log in!"
        redirect to "/login"
      end
    end

    def logout!
      session.clear
    end

  end

  get '/' do
    erb :"index"
  end

end
