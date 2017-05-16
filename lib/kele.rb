require 'httparty'
require 'json'

class Kele
    
include HTTParty

    def initialize(email, password)
        options = { query: { email: email, password: password } }
        sessionsURL = 'https://www.bloc.io/api/v1/sessions'
        @base_url = 'https://www.bloc.io/api/v1'
        response = self.class.post(sessionsURL, options)
        if response["auth_token"]
            @auth_token = response["auth_token"]
        else
            @errors = response["message"]
        end
    end
    
    def get_me
        url = @base_url + '/users/me'
        @response = self.class.get(url, headers: { "authorization" => @auth_token } )
        JSON.parse(@response.body)
    end
    
end