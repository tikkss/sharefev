# -*- encoding : utf-8 -*-
class Ranking < ActiveRecord::Base
  attr_accessible :ip_address

  belongs_to :timeline
end
