# Methods added to this helper will be available to all templates in the application.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.
module ApplicationHelper
  include Refinery::ApplicationHelper # leave this line in to include all of Refinery's core helper methods.
  
  def is_blog?
    request.path =~ /^\/blog.*$/
  end
  
  def is_guides?
    request.path =~ /^\/guides.*$/
  end
  
  def latest_version
    RefinerySetting['hp_latest_version'] ||= HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['version']
  end
  
  def rubygems_downloads
    RefinerySetting['hp_rubygems_downloads'] ||= HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['downloads']
  end
  
  def latest_update
    latest_commit = HTTParty.get("http://github.com/api/v2/json/commits/list/resolve/refinerycms/master")['commits'].first
    RefinerySetting['hp_latest_update'] ||= distance_of_time_in_words(Time.now, latest_commit['committed_date']) + " ago by " + latest_commit['author']['name']
  end
  
  def github_watchers
    RefinerySetting['hp_github_watchers'] ||= HTTParty.get("http://github.com/api/v2/json/repos/show/resolve/refinerycms")['repository']['watchers']
  end
  
end
