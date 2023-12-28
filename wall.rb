require 'net/http'
require 'json'
require 'uri'

# Function to download an image from a URL
def download_image(url, path)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  if response.is_a?(Net::HTTPSuccess)
    File.open(path, 'wb') do |file|
      file.write(response.body)
    end
  end
end

# Function to set the downloaded image as wallpaper
def set_wallpaper(image_path)
  system("gsettings set org.gnome.desktop.background picture-uri 'file://#{image_path}'")
end

# Main script to download a random image and set it as wallpaper
def change_wallpaper_every(interval, resolution)
  while true
    # Konachan API URL for random wallpapers
    api_url = "https://konachan.net/post.json?tags=loli+order:random&limit=1"
    response = Net::HTTP.get(URI(api_url))
    images = JSON.parse(response)

    # Select the first image from the response
    image_url = images.first['file_url']
    image_path = "/tmp/wallpaper.jpg" # Temporary file path

    # Download the image
    download_image(image_url, image_path)

    # Set the image as wallpaper cock
    set_wallpaper(image_path)

    # Wait for the specified interval
    sleep(interval * 60)
  end
end

# Start the script with a 15-minute interval and 1920x1080 resolution
change_wallpaper_every(15, '1920x1080')
