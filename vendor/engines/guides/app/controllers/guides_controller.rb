require File.expand_path('../../helpers/guides_helper', __FILE__)
class GuidesController < ApplicationController
  include GuidesHelper

  before_filter :find_all_guides
  before_filter :find_page

  caches_page :index, :unless => proc {|c| c.user_signed_in? || c.flash.any? }
  caches_page :show, :unless => proc {|c| c.user_signed_in? || c.flash.any? }

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @guide in the line below:
    present(@page)
    respond_to do |format|
      format.json {
        render :json => @guides.to_json({
          :only => [:author, :title, :description],
          :methods => :url
        })
      }
      format.all {
        render :action => 'index'
      }
    end
  end

  def show
    slug = Slug.where(:name => params[:id]).where(:scope => params[:branch] || Guide::BRANCH).first
    @guide = slug ? slug.sluggable : Guide.find(params[:id])
    guide_content = @guide.guide =~ /---/ ? ::YAML::load(@guide.guide) : @guide.guide
    @guide_body = generate_guide(guide_content)

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @guide in the line below:
    present(@page)
  end

  def hook
    Rails.root.join('tmp', 'templates').rmtree if Rails.root.join('tmp', 'templates').directory?

    if request.post? and params.keys.map(&:to_sym).include?(:payload)
      if (push = JSON.parse(params[:payload])).present? && push['ref'] =~ Regexp.new(Guide::BRANCHES.join("|"))
        if push['commits'].any? {|c| [c['added'], c['modified'], c['removed']].flatten.any? {|m| m =~ /guides/ }}
          Guide.refresh_github!(:branch => push['ref'])

          render :nothing => true and return
        end
      end
    end

    logger.warn "**"
    logger.warn "Nothing to update for payload."
    if (homepage = Rails.root.join('public', 'index.html')).file?
      $stdout.puts "However, I'm clearing the homepage due to a Github push."
      homepage.delete
    end
    logger.warn "**"

    render :nothing => true and return
  end

protected

  def find_all_guides
    branch = Guide::BRANCHES.include?(params[:branch]) ? params[:branch] : Guide::BRANCH
    @guides = Guide.order('position ASC').where(:branch => branch)
  end

  def find_page
    @page = Page.where(:link_url => "/#{"edge-" if params[:branch] == 'master'}guides").first
  end

end
