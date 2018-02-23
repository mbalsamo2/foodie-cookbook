class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "cookit"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash
  
  helpers do

  end


  get '/' do
    erb :"index"
  end



end
