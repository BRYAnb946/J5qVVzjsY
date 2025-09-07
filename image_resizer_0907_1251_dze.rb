# 代码生成时间: 2025-09-07 12:51:18
# image_resizer.rb
# A Ruby program using the CUBA framework to batch resize images.

require 'cuba'
require 'mini_magick'

class ImageResizer < Cuba
  # Defines the route to handle image resizing
  define do
    on get do
      on 'resize' do
        # Render the template to handle image resizing
        res.write view('resize.slim')
      end
    end

    on post do
      on 'resize' do
        # Get the uploaded images from the request
        images = params[:images]

        # Check if images were uploaded
        unless images
          res.write 'No images were uploaded.'
          return
        end

        # Resize the images
        resized_images = images.map do |image|
          begin
            # Create a MiniMagick image object
            img = MiniMagick::Image.new(image[:tempfile].path)

            # Resize the image (example: resize to 800x600)
            img.resize '800x600'

            # Generate a filename for the resized image
            filename = SecureRandom.uuid + File.extname(image[:filename])
            img.write filename
          rescue StandardError => e
            # Handle any errors that occur during image processing
            { error: e.message, original_filename: image[:filename] }
          else
            # Return the filename of the resized image
            { success: filename, original_filename: image[:filename] }
          end
        end

        # Return the results of the resize operation
        res.write JSON.pretty_generate(resized_images)
      end
    end
  end
end

ImageResizer.run!