# Methods added to this helper will be available to all templates in the application.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.
module ApplicationHelper

  def is_blog?
    request.path =~ /^\/blog.*$/
  end

  def is_guides?
    request.path =~ /^\/guides.*$/
  end

  def expire_statistics_caches!
    RefinerySetting.set(:last_update, {:value => Time.now, :scoping => :statistics})
    RefinerySetting.set(:version, {:value => nil, :scoping => :statistics})
    RefinerySetting.set(:downloads, {:value => nil, :scoping => :statistics})
    RefinerySetting.set(:commit, {:value => nil, :scoping => :statistics})
    RefinerySetting.set(:watchers, {:value => nil, :scoping => :statistics})
  end

  def latest_version
    if (version = RefinerySetting.get(:version, :scoping => :statistics)).blank?
      version = RefinerySetting.set(:version, {
                  :value => HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['version'],
                  :scoping => :statistics
               })
    end

    version
  end

  def rubygems_downloads
    if (downloads = RefinerySetting.get(:downloads, :scoping => :statistics)).blank?
      downloads = RefinerySetting.set(:downloads, {
                  :value => HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['downloads'],
                  :scoping => :statistics
               })
    end

    downloads
  end

  def latest_update
    if (commit = RefinerySetting.get(:commit, :scoping => :statistics)).blank?
      latest_commit = HTTParty.get("http://github.com/api/v2/json/commits/list/resolve/refinerycms/master")['commits'].first
      commit = RefinerySetting.set(:commit, {
        :value => distance_of_time_in_words(Time.now, latest_commit['committed_date']) + " ago by " + latest_commit['author']['name'],
        :scoping => :statistics
      })
    end

    commit
  end

  def github_watchers
    if (watchers = RefinerySetting.get(:watchers, :scoping => :statistics)).blank?
      watchers = RefinerySetting.set(:watchers, {
        :value => HTTParty.get("http://github.com/api/v2/json/repos/show/resolve/refinerycms")['repository']['watchers'],
        :scoping => :statistics
      })
    end

    watchers
  end

end
