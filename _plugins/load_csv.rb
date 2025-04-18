module Jekyll
  class CSVDataGenerator < Generator
    def generate(site)
      csv_path = File.join(site.source, 'assets', 'wp_images.csv')
      if File.exist?(csv_path)
        require 'csv'
        site.data['wp_images'] = CSV.read(csv_path, headers: true).map do |row|
          {
            'image_id' => row['image_id'],
            'image_name' => row['image_name']
          }
        end
        puts "Loaded #{site.data['wp_images'].size} images from CSV"
      end
    end
  end
end 