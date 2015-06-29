source 'https://rubygems.org'

ruby '1.9.3'

gem 'pg'
gem 'fog'

# REFINERY CMS ================================================================
# Anything you put in here will be overridden when the app gets updated.

gem 'rails', :github => 'rails/rails', :branch => '3-0-stable'
gem 'dragonfly', github: 'markevans/dragonfly', ref: '25d4a4a82c'
gem 'refinerycms', '~> 1.0.10'

# END REFINERY CMS ============================================================

# USER DEFINED
gem 'refinerycms-blog',         '~> 1.6.2'
gem 'httparty'

gem 'refinerycms-guides',       :path => 'vendor/engines', :require => 'guides'
gem 'RedCloth',                 '= 4.2.9'
gem 'rack-rewrite',             '~> 1.0.2'

# Specify additional Refinery CMS Engines here (all optional):
# gem 'refinerycms-inquiries',    '~> 1.0.0'
# gem 'refinerycms-news',       '~> 0.9.9.6'
# gem 'refinerycms-portfolio',  '~> 0.9.9'
# gem 'refinerycms-theming',    '~> 0.9.8.2'
# gem 'refinerycms-search',     '~> 0.9.8'

# Add i18n support (optional, you can remove this if you really want to).
gem 'refinerycms-i18n',         '~> 1.0.0'

# END USER DEFINED

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'newrelic_rpm'
end
