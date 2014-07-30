# -*- encoding : utf-8 -*-

class ArtefatoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def delete_image_folder
    FileUtils.remove_dir(File.join(Rails.root, File.join('public','uploads' , file_name.store_dir)), :force => true)  
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  version :thumb do
    process :resize_to_fill => [95,50]
  end

  version :thumbcb do
    process :resize_to_fill => [200,44]
  end

  version :avatar do 
    process :resize_to_fill => [215,215]
  end



  version :placa do
    process :resize_to_fill => [600,317]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
   %w(jpg jpeg png)
 end


 def default_url
  nome_arquivo = [version_name, "default.png"].compact.join('_')
  ActionController::Base.helpers.asset_url("padrao/"+nome_arquivo)
 end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
