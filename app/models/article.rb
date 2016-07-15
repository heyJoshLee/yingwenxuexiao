class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  sluggable_column :title

end