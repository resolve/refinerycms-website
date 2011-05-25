source 'http://rubygems.org'

gem 'sqlite3'
#gem 'mysql'
gem 'mysql2', '~> 0.2.7'

# REFINERY CMS ================================================================
# Anything you put in here will be overridden when the app gets updated.

git 'git://github.com/resolve/refinerycms.git' do # when it was 1.0.0
  gem 'refinerycms'

  group :development, :test do
    gem 'refinerycms-testing'
  end
end

# END REFINERY CMS ============================================================

# USER DEFINED
gem 'refinerycms-blog', '~> 1.1'
gem 'httparty'

gem 'refinerycms-guides', '1.0', :path => 'vendor/engines', :require => 'guides'
gem 'RedCloth', '= 4.2.2'
gem 'rack-rewrite', '~> 1.0.2'# Specify additional Refinery CMS Engines here (all optional):
# gem 'refinerycms-inquiries',    '~> 1.0.0'
# gem 'refinerycms-news',       '~> 0.9.9.6'
# gem 'refinerycms-portfolio',  '~> 0.9.9'
# gem 'refinerycms-theming',    '~> 0.9.8.2'
# gem 'refinerycms-search',     '~> 0.9.8'

# Add i18n support (optional, you can remove this if you really want to).
gem 'refinerycms-i18n',         '~> 1.0.0'

# END USER DEFINED
