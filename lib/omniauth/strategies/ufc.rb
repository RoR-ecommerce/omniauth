require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ufc < OmniAuth::Strategies::OAuth2
      option :name, "https://launchpad.ufcfit.com"

      option :client_options, {
        site: 'https://api.ufcfit.com',
        authorize_url: 'https://launchpad.ufcfit.com/login/oauth/auth',
        token_url: 'https://launchpad.ufcfit.com/login/oauth/token'
      }

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          name: raw_info['name'],
          email: raw_info['email']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'ufc', 'UFC'
