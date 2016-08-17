require "spec_helper"

describe Download do
  it {should validate_presence_of(:main_image_url) }
  it {should validate_presence_of(:title) }
  it {should validate_presence_of(:body) }
  it {should validate_presence_of(:file_download_url) }
end