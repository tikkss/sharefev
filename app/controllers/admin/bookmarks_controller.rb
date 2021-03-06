# -*- encoding : utf-8 -*-
class Admin::BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    if @bookmark.save
      redirect_to [:admin, @bookmark], :notice => "Successfully created bookmark."
    else
      render :action => 'new'
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(params[:bookmark])
      redirect_to [:admin, @bookmark], :notice  => "Successfully updated bookmark."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to admin_bookmarks_url, :notice => "Successfully destroyed bookmark."
  end
end
