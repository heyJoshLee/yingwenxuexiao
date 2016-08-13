require "spec_helper"

describe Course do
  it { should have_many(:lessons) }
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:description)}

end