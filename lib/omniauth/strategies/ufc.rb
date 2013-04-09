require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ufc < OmniAuth::Strategies::OAuth2
      option :name, "ufc"

      option :client_options, {
        site: 'https://launchpad.ufcfit.com',
        authorize_url: '/oauth/auth',
        token_url: '/oauth/token'
      }

      option :access_token_options, {
        header_format: 'OAuth %s',
        param_name: 'access_token'
      }

      uid { raw_info['uid'].to_s }

      info do
        {
          email: raw_info['email'],
          name: raw_info['email']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/oauth/user').parsed
      end

      protected

      def build_access_token
        super.tap do |token|
          token.options.merge!(access_token_options)
        end
      end

      def access_token_options
        options.access_token_options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end
    end
  end
end

OmniAuth.config.add_camelization 'ufc', 'Ufc'
