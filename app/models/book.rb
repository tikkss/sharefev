# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :name, :title, :checked_url, :linked_url

  extend FriendlyId
  friendly_id :name

  has_many :book_histories, dependent: :restrict
end
