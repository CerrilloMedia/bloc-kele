module RoadMap
    
    def get_roadmap(roadmap_id)
        url = @base_url + "/roadmaps/#{roadmap_id.to_i}"
        parsed_response = parse_to_ruby(url)
        
        puts name = parsed_response["name"]
        sections = parsed_response["sections"]
        
        unless sections.nil? || name.nil?
            sections.map do |section|
                {
                    id: section["id"],
                    name: section["name"],
                    checkpoints: section["checkpoints"].map { |chkpt|
                                {
                                 id: chkpt["id"],
                                 title: chkpt["name"]
                                }
                    }
                }
            end
        else
            parsed_response["message"]
        end
    end
    
    def get_checkpoint(checkpoint_id)
        url = @base_url + "/checkpoints/#{checkpoint_id.to_i}"
        parsed_response = parse_to_ruby(url)
        
        name = parsed_response["name"]
        body = parsed_response["body"]
        
        unless body.nil? || name.nil?
            puts "checkpoint: #{checkpoint_id}"
            {
                name: name,
                body: body
            }
        else
            parsed_response["message"]
        end
    end
end