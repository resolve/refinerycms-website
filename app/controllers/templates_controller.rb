class TemplatesController < ActionController::Metal
  include ActionController::Rendering

  def show
    require 'net/http'
    template_directory = Rails.root.join('tmp', 'templates')
    template_directory.mkdir unless template_directory.directory?
    if params[:tag] == 'edge'
      edge_template = template_directory.join('edge.rb')
      unless edge_template.file?
        Net::HTTP.start("raw.github.com", :use_ssl => true) do |http|
          resp = http.get("/resolve/refinerycms/master/templates/refinery/edge.rb")
          open(edge_template, "wb") do |file|
            file.write(resp.body)
          end
        end
      end
      render :file => edge_template, :content_type => 'text/plain', :layout => nil
    else
      render :nothing => true
    end
  end

end
