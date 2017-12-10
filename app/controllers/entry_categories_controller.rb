class EntryCategoriesController < ApplicationController
  def index
    @categories = EntryCategory.all.map { |c| { text: c.name, value: c.id }}
    render json: { payload: @categories }
  end
end
