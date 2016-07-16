class CategoryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg png)
  end

    def default_url(*args)
      ActionController::Base.helpers.asset_path("image_not_found_fallbacks/" + [version_name, "default.png"].compact.join('_'))
    end



end

