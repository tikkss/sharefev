class Ranking < ActiveRecord::Base
  belongs_to :timeline
  attr_accessible :ip_address
end
