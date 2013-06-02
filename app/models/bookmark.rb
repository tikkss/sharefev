# -*- encoding : utf-8 -*-
class Bookmark < ActiveRecord::Base
  attr_accessible :name, :checked_url, :linked_url
end
