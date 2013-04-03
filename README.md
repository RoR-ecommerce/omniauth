# Omniauth::Ufc

This is the OmniAuth strategy for authentificating to UFCFit.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-ufc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-ufc

## Usage

Each OmniAuth strategy is a Rack Middleware. That means that you can use
it the same way that you use any other Rack middleware.

As far as OmniAuth is built for *multi-provider* authentication, it has
a room to run multiple strategies. For this, the built-in `OmniAuth::Builder`
class gives an easy way to specify multiple strategies.

```ruby
use OmniAuth::Builder do
  provider :ufc, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end
```

The following example you might put into a Rails initializer at `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :ufc, ENV['UFC_CLIENT_ID'], ENV['UFC_CLIENT_SECRET']
end
```

To override default options, you can pass it along with `OmniAuth::Builder`.
It can be helpful for different App environments, like development or staging:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :ufc, ENV['UFC_CLIENT_ID'], ENV['UFC_CLIENT_SECRET'],
    {
      client_options: {
        site: "http://localhost:3001",
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token'
      }
    }
end
```
