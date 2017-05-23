require 'httparty'
require 'json'
require_relative 'roadmap'
require_relative 'messaging'

class Kele
    
include HTTParty
include RoadMap
include Messaging

    def initialize(email, password)
        options = { query: { email: email, password: password } }
        sessionsURL = 'https://www.bloc.io/api/v1/sessions'
        @base_url = 'https://www.bloc.io/api/v1'
        response = self.class.post(sessionsURL, options)
        @auth_token = response["auth_token"]
    end
    
    def get_me
        url = @base_url + '/users/me'
        convert_to_ruby(url)
    end
    
    def get_mentor_availability(id)
        url = @base_url + "/mentors/#{id.to_i}/student_availability"
        
        parsed_response = convert_to_ruby(url)
        
        parsed_response.select do |slot|
          slot["booked"] == nil
       end
    end
    
    private
    
    def convert_to_ruby(url)
        response = self.class.get(url, headers: { "authorization" => @auth_token } )
        JSON.parse(response.body)
    end
    
end