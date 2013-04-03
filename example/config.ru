require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-ufc'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/ufc'
  end

  get '/auth/:provider/callback' do
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :ufc, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
    { client_options: {
        site: "http://localhost:3001",
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token' }
    }
end

run App.new
