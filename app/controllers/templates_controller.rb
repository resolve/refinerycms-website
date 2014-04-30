class TemplatesController < ActionController::Metal
  include ActionController::Rendering

  def show
    require 'net/http'
    template_directory = Rails.root.join('tmp', 'templates')
    template_directory.mkdir unless template_directory.directory?
    version = [params[:major], params[:minor], params[:patch]].compact.join('.')
    if version == 'edge'
      edge_template = template_directory.join('edge.rb')
      unless edge_template.file?
        Net::HTTP.start("raw.githubusercontent.com", :use_ssl => true) do |http|
          resp = http.get("/refinery/refinerycms/master/templates/refinery/edge.rb")
          open(edge_template, "wb") do |file|
            file.write(resp.body)
          end
        end
      end
      render :file => edge_template, :content_type => 'text/plain', :layout => nil
    elsif version.present?
      unless (version_template = template_directory.join("#{version}.rb")).file?
        Net::HTTP.start("raw.githubusercontent.com", :use_ssl => true) do |http|
          url = "/refinery/refinerycms/#{version}/templates/refinery/installer.rb"
          Rails.logger.info "Querying '#{url}'"
          resp = http.get(url)
          if resp.is_a?(Net::HTTPOK)
            Rails.logger.info "Installer found for #{version}!"
            Rails.logger.info "Creating #{version_template}"
            open(version_template, "wb") do |file|
              file.write(resp.body)
            end
          else
            Rails.logger.info "Installer *not* found for #{version} (404)"
            render :text => 'Not Found', :layout => nil, :status => 404 and return
          end
        end
      end
      render :file => version_template, :content_type => 'text/plain', :layout => nil
    else
      render :nothing => true
    end
  end

end
