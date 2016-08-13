require "spec_helper"

describe Level do
  it {should validate_presence_of(:number) }
  it {should validate_presence_of(:points) }
  it {should validate_presence_of(:message) }

  it { should validate_numericality_of(:number).only_integer}
  it { should validate_numericality_of(:points).only_integer}



end