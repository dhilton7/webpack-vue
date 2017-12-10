class EntriesController < ApplicationController
  before_action :set_sheet, only: [:create]

  def create
    @entry = @sheet.entries.new entry_params
    if @entry.save
      render json: { payload: @entry }
    else
      render json: { error: @entry.errors.messages }
    end
  end

  private

  def set_sheet
    @sheet = Sheet.find params[:sheet_id]
  end

  def entry_params
    params.require(:entry).permit(%i[amount account description paid date property_id entry_category_id])
  end
end
