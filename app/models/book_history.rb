# -*- encoding : utf-8 -*-
class BookHistory < ActiveRecord::Base
  attr_accessible :hit_text, :no, :year

  has_many :timelines, dependent: :destroy
  belongs_to :book
end
