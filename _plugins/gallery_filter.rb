module Jekyll
  module GalleryFilter
    def transform_gallery(content)
      return content unless content.is_a?(String)

      # Match [gallery] tags with ids parameter
      content.gsub(/\[gallery[^\]]*ids=[""]([^""]*)[^\]\]]*\]/) do |match|
        # Extract image IDs from the shortcode
        ids = $1.split(',').map(&:strip)
        
        # Create HTML for the gallery
        gallery_html = '<div class="gallery">'
        
        ids.each do |id|
          # Find the image in site.data.wp_images
          image = site.data.wp_images.find { |img| img['image_id'] == id }
          if image
            gallery_html += %Q{<img src="/assets/images/#{image['image_name']}" class="gallery-image" alt="Gallery image #{id}">}
          end
        end
        
        gallery_html += '</div>'
        gallery_html
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::GalleryFilter) 