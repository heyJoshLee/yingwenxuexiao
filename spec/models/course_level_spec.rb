require "spec_helper"

describe CourseLevel do
  it { should validate_presence_of(:name)}
  it { should ensure_length_of(:color).is_equal_to(7)}

end