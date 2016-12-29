class Level < ActiveRecord::Base

  validates_presence_of :number
  validates_presence_of :points
  validates_presence_of :message

  validates_numericality_of :number, {only_integer: true}
  validates_numericality_of :points, {only_integer: true}

  def self.next_level
    count == 0 ? 1 : Level.last.number + 1
  end


end