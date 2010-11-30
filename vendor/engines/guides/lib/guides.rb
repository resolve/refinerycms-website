require 'refinery'

module Refinery
  module Guides
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "guides"
          plugin.activity = {:class => Guide}
        end
        
        require "rails_guides/textile_extensions"
        RedCloth.send(:include, RailsGuides::TextileExtensions)
        
        require "rails_guides/indexer"
      end
    end
  end
end
