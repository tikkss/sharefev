# -*- encoding : utf-8 -*-
class Timeline < ActiveRecord::Base
  belongs_to :book_history
  belongs_to :bookmark
  attr_accessible :hit_text
end
