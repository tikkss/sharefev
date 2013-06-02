# -*- encoding : utf-8 -*-
class Timeline < ActiveRecord::Base
  attr_accessible :book_history_id, :hit_text

  has_many :rankings, dependent: :destroy
  belongs_to :book_history
  belongs_to :bookmark

  validates :book_history_id, uniqueness: {scope: :bookmark_id}
end
