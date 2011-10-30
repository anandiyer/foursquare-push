Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :foursquare, FS_APP_ID, FS_APP_SECRET,
    { :display => 'page', :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
end

module OmniAuth
  module Strategies
    class Foursquare < OAuth2

#      MOBILE_USER_AGENTS =  'webos|ipod|iphone|mobile'

      def request_phase
        options[:display] = mobile_request? ? 'touch' : 'page'
        super
      end

      def mobile_request?
#        ua = Rack::Request.new(@env).user_agent.to_s
#        ua.downcase =~ Regexp.new(MOBILE_USER_AGENTS)

        Rack::Request.new(@env)
        @uri = @env['REQUEST_URI']

        if (@uri.include?'mobile')
          return true
        else
          return false
        end
      end

    end
  end
end
