import os
import re
import yaml

def load_wp_images():
    with open('_data/wp_images.yml', 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def get_image_name(image_id, wp_images):
    for img in wp_images:
        if img['image_id'] == str(image_id):
            return img['image_name']
    return None

def convert_gallery_to_markdown(match, wp_images):
    gallery_text = match.group(0)
    ids_match = re.search(r'ids="([^"]+)"', gallery_text)
    if not ids_match:
        return gallery_text
    
    ids = ids_match.group(1).split(',')
    markdown_images = []
    
    for img_id in ids:
        img_id = img_id.strip()
        img_name = get_image_name(img_id, wp_images)
        if img_name:
            markdown_images.append(f'![Image {img_id}]({{{{ site.image_path }}}}{img_name})')
    
    return '\n'.join(markdown_images)

def process_file(file_path, wp_images):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all gallery shortcodes
    gallery_pattern = r'\[gallery[^\]]*\]'
    new_content = re.sub(
        gallery_pattern,
        lambda m: convert_gallery_to_markdown(m, wp_images),
        content
    )
    
    # Remove backslash before first image tag
    new_content = re.sub(r'\\!\[', '![', new_content)
    
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f'Processed: {file_path}')

def main():
    wp_images = load_wp_images()
    posts_dir = '_posts'
    
    for filename in os.listdir(posts_dir):
        if filename.endswith('.md'):
            file_path = os.path.join(posts_dir, filename)
            process_file(file_path, wp_images)

if __name__ == '__main__':
    main() 