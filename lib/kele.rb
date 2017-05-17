require 'httparty'
require 'json'

class Kele
    
include HTTParty

    def initialize(email, password)
        options = { query: { email: email, password: password } }
        sessionsURL = 'https://www.bloc.io/api/v1/sessions'
        @base_url = 'https://www.bloc.io/api/v1'
        response = self.class.post(sessionsURL, options)
        @auth_token = response["auth_token"]
    end
    
    def get_me
        url = @base_url + '/users/me'
        response = self.class.get(url, headers: { "authorization" => @auth_token } )
        parsed_response = JSON.parse(response.body)
    end
    
    def get_mentor_availability(id)
       url = @base_url + "/mentors/#{id}/student_availability"
       response = self.class.get(url, headers: { "authorization" => @auth_token } )
       parsed_response = JSON.parse(response.body)
       
       parsed_response.select do |slot|
          slot["booked"] == nil
       end
    end
    
end