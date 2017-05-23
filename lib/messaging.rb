module Messaging
    
    def get_messages(page=0)
        
        url = @base_url + "/message_threads?"
        
        messages = []
        
        page = 0 if page == 0 || page.nil? || !page.integer?
        
        if page == 0
            
            parsed_response = convert_to_ruby(url)
            count = parsed_response["count"]
            
            until messages.count >= count
                page += 1
                parsed_response = convert_to_ruby(url+"page=#{page}")
                messages << parsed_response["items"]
                messages.flatten! #message objects remain intact
            end
        else
            parsed_response = convert_to_ruby("#{url}page=#{page}")
            messages = parsed_response["items"]
        end
        
        messages.empty? ? "no messages found at page requested" : messages
    end
    
    
    
    def create_message(sender, recipient_id, message_body, *args)
        
        puts options = {
            query: {
                "sender" => sender,
                "recipient_id" => recipient_id,
                "stripped-text" => message_body
            },
            headers: {
                "authorization" => @auth_token
            } 
        }
        
        #token format validation
        regex = /^[a-f0-9]{8}(-[a-f0-9]{4}){3}-[a-f0-9]{12}$/
        
        token = nil
        subject = nil
        
        # check if token or subject are present and args does not exceed 2 items
        if args && args.count <= 2
            args.map do |arg|
                if arg.match(regex)
                    token = arg if token.nil?
                else
                    subject = arg if subject.nil?
                end
            end
        else
           return "too many arguments passed into method. 5 max. Please try again."
        end
        
        options[:query]["token"] = token if token
        options[:query]["subject"] = subject if subject
        
        postURL = @base_url + '/messages'
        
        response = self.class.post(postURL, options).parsed_response
        
        response.nil? ? "message sent!" : response["message"]
    end
    
end