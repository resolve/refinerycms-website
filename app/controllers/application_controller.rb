# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.

class ApplicationController < ActionController::Base
  prepend_around_filter :cache_control
  
  def cache_control
    yield
    
    # If this is a GET request then add a 1 minute cache-control header to allow scaling
    if request.get? && Rails.env.production?
      # We don't want to cache or disable session on login pages, the following is a hack to identify a login
      # page, until some modification is made to those controllers to make them more easily identifiable:
      current_layout = self.send :_layout
      
      # Only cache if user is not signed in to /refinery and controller is not a login controller
      if !self.user_signed_in? && current_layout != 'login'
        # Caching for just 1 minute for scaling purposes, :public is used to allow intermediate proxies to cache,
        # 'public' is not appropriate if the page has content specific to the current user/session.
        expires_in 1.minute, :public => true
        
        # The next line is important to ensure that gzipped version isn't sent to browsers that don't support it
        response.headers["Vary"] = "Accept-Encoding"
        
        # We have to disable the session so that cookies aren't sent, as it would prevent caching on good proxies
        # and cause shared session ids on bad proxies! Obviously breaks session reliant behaviour.
        if session.class.method_defined? :destroy
          session.destroy 
        end
      end
    end
  end
end
