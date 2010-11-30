source 'http://rubygems.org'
gem 'bundler', '~> 1.0.5'
gem 'rails', '~> 3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'mysql'
gem 'mysql2'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# REFINERY CMS ================================================================

java = (RUBY_PLATFORM == 'java')

# Specify the Refinery CMS core:
gem 'refinerycms',              :git => 'git://github.com/resolve/refinerycms.git'

# Specify additional Refinery CMS Engines here (all optional):
gem 'refinerycms-inquiries',    '~> 0.9.9.5'
gem 'refinerycms-generators',   '~> 0.9.9', :git => 'git://github.com/resolve/refinerycms-generators.git'
# gem 'refinerycms-news',       '~> 0.9.9.6'
# gem 'refinerycms-portfolio',  '~> 0.9.9'
# gem 'refinerycms-theming',    '~> 0.9.8.2'
# gem 'refinerycms-search',     '~> 0.9.8'

# Add i18n support (optional, you can remove this if you really want to).
gem 'refinerycms-i18n',         '~> 0.9.8.11'

gem 'jruby-openssl' if java

# override dragonfly because this version doesn't require RMagick
gem 'dragonfly',                :git => 'git://github.com/refinerycms/dragonfly.git',
                                :branch => 'master'

group :test do
  # RSpec
  gem 'rspec-rails',            '~> 2.1'
  # Cucumber
  gem 'capybara',               :git => 'git://github.com/parndt/capybara.git'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'spork' unless Bundler::WINDOWS
  gem 'launchy'
  gem 'gherkin'
  gem 'rack-test',              '~> 0.5.6'
  # FIXME: Update json_pure to 1.4.7 when it is released
  gem 'json_pure',              '~> 1.4.6', :require => 'json/pure'
  # Factory Girl
  gem 'factory_girl'
  gem "#{'j' if java}ruby-prof" unless defined?(RUBY_ENGINE) and RUBY_ENGINE == 'rbx'
  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-notification'
  # FIXME: Replace when new babosa gem is released
  gem 'babosa', '0.2.0',        :git => 'git://github.com/stevenheidel/babosa.git' if java
end

# END REFINERY CMS ============================================================

# USER DEFINED
gem 'refinerycms-blog', :git => 'git://github.com/resolve/refinerycms-blog.git'
# END USER DEFINED

gem 'httparty'

gem 'refinerycms-guides', '1.0', :path => 'vendor/engines', :require => 'guides'
gem 'RedCloth', "= 4.2.2"