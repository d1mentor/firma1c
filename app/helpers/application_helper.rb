module ApplicationHelper
    def current_url
        request.env['PATH_INFO']
    end    
end
