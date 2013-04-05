require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-ufc'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/ufc'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env['omniauth.auth']) rescue "No Data"
  end

  get '/auth/failure' do
    content_type 'text/html'
    MultiJson.encode(request.env['omniauth.auth']) rescue "No Data"
  end
end

use Rack::Session::Cookie, secret: ENV['RACK_COOKIE_SECRET']

use OmniAuth::Builder do
  provider :ufc, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
    { client_options: {
        site: "http://localhost:3001",
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token' }
    }
end

run App.new
