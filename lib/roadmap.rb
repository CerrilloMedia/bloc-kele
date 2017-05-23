module RoadMap
    
    def get_roadmap(roadmap_id)
        url = @base_url + "/roadmaps/#{roadmap_id.to_i}"
        parsed_response = convert_to_ruby(url)
        
        name = parsed_response["name"]
        sections = parsed_response["sections"]
        
        unless sections.nil? || name.nil?
            puts name
            sections.map do |section|
                {
                    "section" => section["id"],
                    "checkpoints" => section["checkpoints"].map { |chkpt|
                                chkpt["id"]
                            }
                }
            end
        else
            parsed_response["message"]
        end
    end
    
    def get_checkpoint(checkpoint_id)
        url = @base_url + "/checkpoints/#{checkpoint_id.to_i}"
        parsed_response = convert_to_ruby(url)
        
        body = parsed_response["body"]
        assignment = parsed_response["assignment"]
        
        unless body.nil? || assignment.nil?
            puts "checkpoint: #{checkpoint_id}"
            {
                "body" => body,
                "assignment" => assignment
            }
        else
            parsed_response["message"]
        end
    end
end