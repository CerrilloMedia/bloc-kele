module Submission
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, submission_comment)
        
        user = self.get_me
        user_name = user["name"]
        github_handle = user["github_handle"]
        enrollment_id = user["current_enrollment"]["id"]
        checkpoint_name = self.get_checkpoint(checkpoint_id)[:name]
        
        puts options = {
            query: {
                assignment_branch: assignment_branch,
                assignment_commit_link: assignment_commit_link,
                checkpoint_id: checkpoint_id,
                comment: submission_comment,
                enrollment_id: enrollment_id
            },
            headers: {
                content_type: 'application/json',
                authorization: @auth_token
            } 
        }
        
        postURL = @base_url + '/checkpoint_submissions'
        
        puts "\nSubmitting assignment for \"#{checkpoint_name}\" by #{user_name}..."
        
        response = self.class.post(postURL,options)
        
        if response["status"] == 'submitted'
            "checkpoint submission successfull"
        else
            "An error has occured please try again"
        end
        
    end
    
end