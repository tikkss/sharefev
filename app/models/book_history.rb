# -*- encoding : utf-8 -*-
class BookHistory < ActiveRecord::Base
  attr_accessible :hit_text, :no, :year

  has_many :timelines, dependent: :destroy
  belongs_to :book

  scope :recent, limit(3).order('book_histories.created_at desc')
end
