module GuidesHelper

  def generate_guide(guide)
    view = ActionView::Base.new(".") # don't ask. dirty hack to work in with rails guides
    body = guide
    body = set_header_section(body, view)
    body = set_index(body, view)
    view.content_for(:body) { textile(body).html_safe }

    view
  end

  def textile(body, lite_mode=false)
    # If the issue with notextile is fixed just remove the wrapper.
    with_workaround_for_notextile(body) do |body|
      t = RedCloth.new(body)
      t.hard_breaks = false
      t.lite_mode = lite_mode
      t.to_html(:notestuff, :plusplus, :code, :tip)
    end
  end

  # For some reason the notextile tag does not always turn off textile. See
  # LH ticket of the security guide (#7). As a temporary workaround we deal
  # with code blocks by hand.
  def with_workaround_for_notextile(body)
    code_blocks = []

    body.gsub!(%r{<(yaml|shell|ruby|erb|html|sql|plain)>(.*?)</\1>}m) do |m|
      brush = case $1
        when 'ruby', 'sql', 'plain'
          $1
        when 'erb'
          'ruby; html-script: true'
        when 'html'
          'xml' # html is understood, but there are .xml rules in the CSS
        else
          'plain'
      end

      code_blocks.push(<<HTML)
<notextile>
<div class="code_container">
<pre class="brush: #{brush}; gutter: false; toolbar: false">
#{ERB::Util.h($2).strip}
</pre>
</div>
</notextile>
HTML
      "\ndirty_workaround_for_notextile_#{code_blocks.size - 1}\n"
    end

    body = yield body

    body.gsub(%r{<p>dirty_workaround_for_notextile_(\d+)</p>}) do |_|
      code_blocks[$1.to_i]
    end
  end

  # other sections

  def set_header_section(body, view)
    new_body = body.gsub(/(.*?)endprologue\./m, '').strip
    header = $1

    header =~ /h2\.(.*)/
    page_title = "Ruby on Rails Guides: #{$1.strip}"

    header = textile(header)

    view.content_for(:page_title) { page_title.html_safe }
    view.content_for(:header_section) { header.html_safe }
    new_body
  end

  def set_index(body, view)
    index = <<-INDEX
    <div id="subCol">
      <h3 class="chapter"><img src="/images/chapters_icon.gif" alt="" />Chapters</h3>
      <ol class="chapters">
    INDEX

    i = Indexer.new(body, '')
    i.index

    # Set index for 2 levels
    i.level_hash.each do |key, value|
      link = view.content_tag(:a, :href => key[:id]) { textile(key[:title], true).html_safe }

      children = value.keys.map do |k|
        view.content_tag(:li,
          view.content_tag(:a, :href => k[:id]) { textile(k[:title], true).html_safe })
      end

      children_ul = children.empty? ? "" : view.content_tag(:ul, children.join(" ").html_safe)

      index << view.content_tag(:li, link.html_safe + children_ul.html_safe)
    end

    index << '</ol>'
    index << '</div>'

    view.content_for(:index_section) { index.html_safe }

    i.result
  end

  def guide(name, url, options = {}, &block)
    link = content_tag(:a, :href => url) { name }
    result = content_tag(:dt, link)

    if options[:work_in_progress]
      result << content_tag(:dd, 'Work in progress', :class => 'work-in-progress')
    end

    result << content_tag(:dd, capture(&block))
    result
  end

  def author(name, nick, image = 'credits_pic_blank.gif', &block)
    image = "images/#{image}"

    result = content_tag(:img, nil, :src => image, :class => 'left pic', :alt => name)
    result << content_tag(:h3, name)
    result << content_tag(:p, capture(&block))
    content_tag(:div, result, :class => 'clearfix', :id => nick)
  end

  def code(&block)
    c = capture(&block)
    content_tag(:code, c)
  end

end
