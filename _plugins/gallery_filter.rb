module Jekyll
  module GalleryFilter
    def transform_gallery(content)
      content.gsub(/\[gallery[^\]]*ids="([^"]*)"[^\]]*\]/) do |match|
        ids = $1.split(',')
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
end

Liquid::Template.register_filter(Jekyll::GalleryFilter) 