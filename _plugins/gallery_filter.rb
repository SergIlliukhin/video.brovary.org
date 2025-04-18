module Jekyll
  class GalleryGenerator < Generator
    def generate(site)
      # Load CSV file
      csv_path = File.join(site.source, 'assets', 'wp_images.csv')
      if File.exist?(csv_path)
        require 'csv'
        site.data['wp_images'] = []
        CSV.foreach(csv_path, headers: true) do |row|
          site.data['wp_images'] << {
            'id' => row['id'],
            'url' => row['url'],
            'title' => row['title'] || ''
          }
        end
      end
    end
  end

  module GalleryFilter
    def transform_gallery(input)
      return input unless input.is_a?(String)
      
      # Load CSV data if not already loaded
      unless @wp_images
        csv_path = File.join(@context.registers[:site].source, 'assets', 'wp_images.csv')
        if File.exist?(csv_path)
          require 'csv'
          @wp_images = []
          CSV.foreach(csv_path, headers: true) do |row|
            @wp_images << {
              'id' => row['id'],
              'url' => row['url'],
              'title' => row['title'] || ''
            }
          end
        else
          @wp_images = []
        end
      end
      
      # Handle gallery shortcodes with escaped brackets
      input.gsub(/\\\[gallery[^\]]*ids=["']([^"'\]]+)["'][^\]]*\\\]/) do |match|
        process_gallery($1)
      end
    end
    
    private
    
    def process_gallery(ids_string)
      return '' unless ids_string
      
      ids = ids_string.split(',').map(&:strip)
      gallery_html = '<div class="gallery">'
      
      ids.each do |id|
        image = @wp_images.find { |img| img['id'].to_s == id.to_s }
        if image
          filename = File.basename(image['url'].to_s)
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