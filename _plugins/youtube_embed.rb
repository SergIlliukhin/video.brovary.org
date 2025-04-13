module Jekyll
  module YouTubeEmbed
    def youtube_embed(input)
      return input unless input.is_a?(String)
      
      # First handle [embed] tags
      input = input.gsub(/\[embed\](https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)(\?[^\]]*)?\[\/embed\]/i) do |match|
        video_id = $4
        %Q{<div class="youtube-embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>}
      end
      
      # Then handle direct URLs
      input.gsub(/(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)(?:\s|$)/) do |match|
        video_id = $1
        %Q{<div class="youtube-embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>}
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::YouTubeEmbed) 