require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ufc < OmniAuth::Strategies::OAuth2

      option :client_options, {
        site: 'https://launchpad.ufcfit.com',
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token'
      }

      uid { raw_info['id'].to_s }

      info do
        { email: raw_info['email'] }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/oauth/user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'ufc', 'Ufc'
