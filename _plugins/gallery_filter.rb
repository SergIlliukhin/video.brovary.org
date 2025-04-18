module Jekyll
  module GalleryFilter
    def transform_gallery(input)
      return input unless input.is_a?(String)
      
      # Handle gallery shortcodes with escaped brackets
      input = input.gsub(/\\\[gallery[^\]]*ids=["']([^"'\]]+)["'][^\]]*\\\]/) do |match|
        process_gallery($1)
      end
      
      # Handle gallery shortcodes with unescaped brackets
      input = input.gsub(/\[gallery[^\]]*ids=["']([^"'\]]+)["'][^\]]*\]/) do |match|
        process_gallery($1)
      end
      
      input
    end
    
    private
    
    def process_gallery(ids_string)
      return '' unless ids_string
      
      ids = ids_string.split(',').map(&:strip)
      gallery_html = '<div class="gallery">'
      
      ids.each do |id|
        # Try to find image in site data
        image = begin
          site = @context.registers[:site]
          if site && site.data && site.data['wp_images']
            site.data['wp_images'].find { |img| img['id'].to_s == id.to_s }
          end
        rescue
          nil
        end
        
        if image
          filename = File.basename(image['url'].to_s)
          new_url = "#{@context.registers[:site].config['baseurl']}/assets/images/#{filename}"
          gallery_html += %Q{<img src="#{new_url}" alt="#{image['title']}" class="gallery-image">}
        end
      end
      
      gallery_html += '</div>'
      gallery_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::GalleryFilter) 