# 代码生成时间: 2025-08-09 12:22:04
# archive_extractor.rb
# This script is a simple file archive extractor using Ruby.
# It demonstrates how to extract archives using the Cuba framework.

require 'cuba'
require 'zip'
require 'tar'
require 'cuba/render'
require 'fileutils'

# Define the Cuba app
Cuba.define do
  # Define a route for the archive extraction
  on get  do
    on "extract" do
      # Render a simple HTML form for file upload
      res.write "<form action='/extract' method='post' enctype='multipart/form-data'>
"
      res.write "<input type='file' name='archive'>
"
      res.write "<input type='submit' value='Extract'>
"
      res.write "</form>
"
    end
  end

  # Define a route for the POST request to handle file upload and extraction
  on post do
    on "extract" do
      # Check if a file is uploaded
      if env['rack.request.form_hash'][:archive]
        archive = env['rack.request.form_hash'][:archive][:tempfile]
        filename = env['rack.request.form_hash'][:archive][:filename]

        # Determine the archive type and extract accordingly
        case File.extname(filename)
        when '.zip'
          # Extract zip files
          extract_zip(archive, filename)
        when '.tar', '.tar.gz', '.tgz', '.tar.bz2'
          # Extract tar files
          extract_tar(archive, filename)
        else
          # Return an error if the file type is not supported
          status 415
          res.write "Unsupported file type"
        end
      else
        # Return an error if no file is uploaded
        status 400
        res.write "No file uploaded"
      end
    end
  end
end

# Helper method to extract zip files
def extract_zip(archive, filename)
  # Create a directory to store the extracted files
  extract_dir = "./#{File.basename(filename, '.*')}_extracted"
  FileUtils.mkdir_p(extract_dir)

  # Extract the zip file into the directory
  Zip::File.open(archive) do |zip_file|
    zip_file.each do |entry|
      entry.extract("#{extract_dir}/#{entry.name}")
    end
  end

  # Inform the user of the extraction success
  res.write "Archive extracted to #{extract_dir}"
end

# Helper method to extract tar files
def extract_tar(archive, filename)
  # Create a directory to store the extracted files
  extract_dir = "./#{File.basename(filename, '.*')}_extracted"
  FileUtils.mkdir_p(extract_dir)

  # Extract the tar file into the directory
  if filename.end_with?('.tar.gz') || filename.end_with?('.tgz')
    system("tar -xzf #{archive.path} -C #{extract_dir}")
  elsif filename.end_with?('.tar.bz2')
    system("tar -xjf #{archive.path} -C #{extract_dir}")
  else
    system("tar -xf #{archive.path} -C #{extract_dir}")
  end

  # Inform the user of the extraction success
  res.write "Archive extracted to #{extract_dir}"
end