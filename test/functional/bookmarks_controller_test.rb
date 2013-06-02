# -*- encoding : utf-8 -*-
require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Bookmark.first
    assert_template 'show'
  end
end
