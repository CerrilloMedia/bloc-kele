require 'httparty'

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
    
    
end