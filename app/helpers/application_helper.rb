# Methods added to this helper will be available to all templates in the application.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.
module ApplicationHelper

  def is_blog?
    request.path =~ /^\/blog.*$/
  end

  def is_guides?
    request.path =~ /^\/(edge-)?guides.*$/
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
      begin
        version = RefinerySetting.set(:version, {
                    :value => HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['version'],
                    :scoping => :statistics
                 })
      rescue
        version = Refinery.version
      end
    end

    version.to_s
  end

  def rubygems_downloads
    if (downloads = RefinerySetting.get(:downloads, :scoping => :statistics)).blank?
      begin
        downloads = RefinerySetting.set(:downloads, {
                    :value => HTTParty.get("http://rubygems.org/api/v1/gems/refinerycms.json")['downloads'],
                    :scoping => :statistics
                 })
      rescue
        downloads = 'info is currently unavailable.'
      end
    end

    downloads
  end

  def latest_update
    begin
      if (commit = RefinerySetting.get(:commit, :scoping => :statistics)).blank?
        latest_commit = HTTParty.get("https://api.github.com/repos/refinery/refinerycms/commits").parsed_response.first["commit"]["committer"]
        commit = RefinerySetting.set(:commit, {
          :value => distance_of_time_in_words(Time.now.utc - Time.parse(latest_commit["date"]).utc) + " ago by " + latest_commit['name'],
          :scoping => :statistics
        })
      end
      commit
    rescue Exception
      ""
    end
  end

  def github_watchers
    begin
      if (watchers = RefinerySetting.get(:watchers, :scoping => :statistics)).blank?
        watchers = RefinerySetting.set(:watchers, {
          :value => HTTParty.get("https://api.github.com/repos/refinery/refinerycms").parsed_response['watchers'],
          :scoping => :statistics
        })
      end

      watchers
    rescue Exception
      ""
    end
  end

end
