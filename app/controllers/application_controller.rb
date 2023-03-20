class ApplicationController < ActionController::Base
	before_action :redirect_from_www_to_non_www_host

  def redirect_from_www_to_non_www_host
    domain_parts = request.host.split('.')
    if domain_parts.first == 'www'
      redirect_to(request.original_url.gsub('www.', ''), status: 301, allow_other_host: true) and return  
    end
  end  
end
