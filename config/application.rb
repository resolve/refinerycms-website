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

    config.after_initialize do
      ::PagesController.module_eval do
        caches_page :show, :unless => proc {|c| c.user_signed_in? || c.flash.any? }
        caches_page :home, :unless => proc {|c| c.user_signed_in? || c.flash.any? }
      end
      ::Blog::PostsController.module_eval do
        # Can't cache blog index because it uses paging :(
        #caches_page :index, :unless => proc {|c| c.user_signed_in? || c.flash.any? }
        #caches_page :show, :unless => proc {|c| c.user_signed_in? || c.flash.any? }
      end
    end

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
      r301 "/blog/an-overview-of-refinery-cms-rails-magazine","/blog/rails-magazine-article-an-overview-of-refinery"
      r301 "/overview","/"
      r301 "/blog/refinery-turns-you-into-a-web-design-super-hero","/"
      r301 "/contact-page","/contact"

      # more generic ones.
      r301 %r{/blog/tag/.*},"/blog"
      r301 %r{/blog/author/.*},"/blog"

      # tutorial site redirects
      r301 "/tutorials","http://refinerycms.com/guides"
      r301 "/tutorials/","http://refinerycms.com/guides"
      r301 "/tutorials/tagged/installation","http://refinerycms.com/download"
      r301 "/tutorials/how-to-test-refinery","http://refinerycms.com/guides/how-to-test-refinery"
      r301 "/tutorials/how-to-install-refinery","http://refinerycms.com/download"
      r301 "/tutorials/translate-refinery-into-your-language","http://refinerycms.com/guides/translate-refinery-into-your-language"

      r301 "/tutorials/how-to-override-a-view","http://refinerycms.com/guides/how-to-override-a-view"
      r301 "/tutorials/using-sass-in-your-themes","http://refinerycms.com/guides/using-sass-in-your-views"
      r301 "/tutorials/how-to-install-refinery-on-heroku","http://refinerycms.com/guides/how-to-install-refinery-on-heroku"
      r301 "/tutorials/how-to-contribute-to-refinery-development","http://refinerycms.com/guides/how-to-contribute-to-refinery"
      r301 "/tutorials/how-to-add-image-gallery-to-pages","http://refinerycms.com/guides/how-to-add-an-image-gallery-to-pages"
      r301 "/tutorials/how-to-upgrade-to-edge-refinery","http://refinerycms.com/guides/how-to-upgrade-to-edge-refinery"
      r301 "/tutorials/tabbed-fields-in-your-engines-admin-area","http://refinerycms.com/guides/tabbed-fields-in-your-engines-admin-area"
      r301 "/tutorials/how-to-update-refinery-to-the-latest-version","http://refinerycms.com/guides/how-to-update-refinery-to-the-latest-stable-version"
      r301 "/tutorials/how-to-change-the-default-and-individual-page-parts","http://refinerycms.com/guides/how-to-change-page-parts"
      r301 "/contribute","http://refinerycms.com/guides/how-to-contribute-to-refinery-development"
      r301 "/tutorials/how-to-get-help-with-refinery","http://refinerycms.com/guides/how-to-get-help-with-refinery"
      r301 "/tutorials/tagged/testing","http://refinerycms.com/guides/how-to-test-refinery"
      r301 "/tutorials/tagged/update","http://refinerycms.com/guides/how-to-update-refinery-to-the-latest-stable-version"
      r301 "/tutorials/tagged/help","http://refinerycms.com/guides/how-to-get-help-with-refinery"

      # generic tagged routes
      r301 %r{/tutorials/tagged/.*},"http://refinerycms.com/guides"
    end
  end
end
