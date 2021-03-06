class EntriesController < ApplicationController
  before_action :set_sheet, only: [:create]

  def create
    @entry = @sheet.entries.new entry_params
    render json: { error: @entry.errors.messages } unless @entry.save
  end

  private

  def set_sheet
    @sheet = Sheet.find params[:sheet_id]
  end

  def entry_params
    params.require(:entry).permit(%i[amount account description paid date property_id entry_category_id])
  end
end
