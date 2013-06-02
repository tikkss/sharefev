# -*- encoding : utf-8 -*-
class BookHistory < ActiveRecord::Base
  belongs_to :book
  attr_accessible :hit_text, :no, :year
end
