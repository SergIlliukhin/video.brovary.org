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
            'id' => row['image_id'],
            'url' => row['image_name']
          }
        end
        puts "Loaded #{site.data['wp_images'].size} images from CSV"
      end
    end
  end

  module GalleryFilter
    def transform_gallery(content)
      return content unless content.is_a?(String)
      
      puts "Starting gallery transformation..."
      
      # Process unescaped shortcodes
      content = content.gsub(/\[gallery[^\]]*ids=[""]([^""]*)[^\]\]]*\]/) do |match|
        puts "Found unescaped gallery: #{match}"
        process_gallery($1, @context.registers[:site])
      end

      # Process escaped shortcodes
      content = content.gsub(/\\\[gallery[^\]]*ids=[""]([^""]*)[^\]\]]*\\\]/) do |match|
        puts "Found escaped gallery: #{match}"
        process_gallery($1, @context.registers[:site])
      end

      content
    end
    
    private
    
    def process_gallery(ids, site)
      puts "Processing gallery with IDs: #{ids}"
      image_ids = ids.split(',').map(&:strip)
      puts "Split IDs: #{image_ids.inspect}"
      
      images = image_ids.map do |id|
        image = site.data['wp_images'].find { |img| img['id'] == id }
        puts "Found image for ID #{id}: #{image ? image['url'] : 'not found'}"
        image
      end.compact
      
      puts "Found #{images.size} images out of #{image_ids.size} IDs"
      
      html = '<div class="gallery">'
      images.each do |image|
        filename = image['url']
        new_url = "/assets/images/#{filename}"
        html += "<img src=\"#{new_url}\" class=\"gallery-image\" alt=\"\">"
      end
      html += '</div>'
      
      puts "Generated HTML: #{html}"
      html
    end
  end
end

Liquid::Template.register_filter(Jekyll::GalleryFilter) 