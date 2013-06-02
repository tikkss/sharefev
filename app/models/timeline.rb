# -*- encoding : utf-8 -*-
class Timeline < ActiveRecord::Base
  attr_accessible :hit_text

  has_many :rankings, dependent: :destroy
  belongs_to :book_history
  belongs_to :bookmark
end
