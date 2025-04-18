module Jekyll
  module GalleryFilter
    def transform_gallery(content)
      # First handle escaped shortcodes without paragraph tags
      content = content.gsub(/\\\[gallery[^\]]*\\\]/) do |match|
        # Extract the ids parameter using a more flexible approach
        ids_match = match.match(/ids=["']?([^"'\]]+)["']?/)
        if ids_match
          process_gallery(ids_match[1])
        else
          match
        end
      end
      
      # Then handle unescaped shortcodes without paragraph tags
      content = content.gsub(/\[gallery[^\]]*\]/) do |match|
        # Extract the ids parameter using a more flexible approach
        ids_match = match.match(/ids=["']?([^"'\]]+)["']?/)
        if ids_match
          process_gallery(ids_match[1])
        else
          match
        end
      end
      
      content
    end
    
    private
    
    def process_gallery(ids_string)
      ids = ids_string.split(',')
      gallery_html = '<div class="gallery">'
      ids.each do |id|
        image = @context.registers[:site].data['wp_images'].find { |img| img['id'] == id.strip }
        if image
          # Extract just the filename from the URL
          filename = File.basename(image['url'])
          # Create the new path in assets/images
          new_url = "/assets/images/#{filename}"
          gallery_html += %Q{<img src="#{new_url}" alt="#{image['title']}" class="gallery-image">}
        end
      end
      gallery_html += '</div>'
      gallery_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::GalleryFilter) 