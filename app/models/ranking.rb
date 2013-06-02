# -*- encoding : utf-8 -*-
class Ranking < ActiveRecord::Base
  belongs_to :timeline
  attr_accessible :ip_address
end
