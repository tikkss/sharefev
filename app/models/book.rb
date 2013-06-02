# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :name, :title, :checked_url, :linked_url
end
