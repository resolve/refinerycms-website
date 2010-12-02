require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module RefinerycmsWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w()

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    
    require 'rack/rewrite'
 
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 "/inquiries/new","/contact"
      r301 "/blog/author/Barry Harrison","/blog"
      r301 "/blog/author/Patrick","/blog"
      r301 "/blog/award-updates","/blog/awards-updates"
      r301 "/blog/category/Releases","/blog"
      r301 "/blog/hosting-deploying-refinery-on-heroku","/blog/deploying-refinery-on-heroku"
      r301 "/blog/open-source-awards","/blog/resolve-digital-is-a-finalist-in-the-2010-new-zealand-open-source-awards"
      r301 "/blog/plugin","/engines"
      r301 "/blog/refinery-cms-0-9-7-released","/blog/whats-new-in-refinery-097"
      r301 "/blog/refinery-cms-supports-rails-3","/blog/refinery-cms-now-supports-rails-3"
      r301 "/blog/refinery-in-the-news","/blog/refinery-resolve-digital-in-the-news"
      r301 "/blog/refinery-live-support","/blog"
      r301 "/blog/refineryhq-goes-live","/blog/plunging-into-the-gaping-unknown-refineryhq-goes-live"
      r301 "/blog/tag/Hosting","/blog/categories/hosting"
      r301 "/blog/tag/Rails3","/blog/refinery-cms-now-supports-rails-3"
      r301 "/developers","/"
      r301 "/examples","/showcase"
      r301 "/testimonials","/community"
      r301 "/blog/an-overview-of-refinery-cms-rails-magazine","/blog/rails-magazine-article-an-overview-of-refinery"
      r301 "/overview","/"
      r301 "/blog/refinery-turns-you-into-a-web-design-super-hero","/"
      r301 "/contact-page","/contact"
      
      # more generic ones.
      r301 %r{/blog/tag/*},"/blog"
      r301 %r{/blog/author/.*},"/blog"
    end
  end
end
