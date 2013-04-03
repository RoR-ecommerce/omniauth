require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ufc < OmniAuth::Strategies::OAuth2

      option :client_options, {
        site: 'https://launchpad.ufcfit.com',
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token'
      }

      def request_phase
        super
      end

      uid { raw_info['id'].to_s }

      info do
        { email: raw_info['email'] }
      end

      extra do
        { raw_info: raw_info }
      end

      # TODO get user info from launchpad/API.
      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'ufc', 'Ufc'
