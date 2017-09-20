class EntryCategoriesController < ApplicationController
  def index
    @categories = EntryCategory.all.map(&:name)
    render json: { payload: @categories }
  end
end
