require File.expand_path('../../helpers/guides_helper', __FILE__)
class GuidesController < ApplicationController
  include GuidesHelper

  before_filter :find_all_guides
  before_filter :find_page

  caches_page :index, :unless => proc {|c| c.user_signed_in?}
  caches_page :show, :unless => proc {|c| c.user_signed_in?}

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
    @guide = Guide.find(params[:id])
    @guide_body = generate_guide(::YAML::load(@guide.guide))

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @guide in the line below:
    present(@page)
  end

  def hook
    if request.post? and params.keys.map(&:to_sym).include?(:payload)
      #push = JSON.parse(params[:payload])

      Guide.refresh_github!

      render :nothing => true
    end
  end

protected

  def find_all_guides
    @guides = Guide.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/guides")
  end

end
