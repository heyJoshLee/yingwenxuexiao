require "spec_helper"

describe Article do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}
  # it { should validate_presence_of(:main_image_url)}
  it { should belong_to(:author) }
  it { should have_many(:article_topics) }
  it { should have_many(:comments) }


end