class GuidesController < ApplicationController

  before_filter :find_all_guides
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @guide in the line below:
    present(@page)
    respond_to do |format|
      format.json { render :json => @guides.to_json }
      format.all { render :action => 'index' }
    end
  end

  def show
    @guide = Guide.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @guide in the line below:
    present(@page)
  end

protected

  def find_all_guides
    @guides = Guide.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/guides")
  end

end
