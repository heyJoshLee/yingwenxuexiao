class EbookSrcUploader < CarrierWave::Uploader::Base

  def extension_white_list
    %w(pdf)
  end

end