class SheetsController < ApplicationController
  before_action :set_sheet, only: %i[edit update destroy]

  def create
    @sheet = current_user.sheets.new sheet_params
    if @sheet.save
      render json: { success: true }, status: :created
    else
      render json: { error: @sheet.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    @sheet = Sheet.find params[:id]
    @entries = Entry.entries_for_sheet params[:id]
    # TODO: Make this data driven
    @headers = [
      { name: 'Income', value: '$4000' },
      { name: 'Expenses', value: '$1600' },
      { name: 'Cashflow', value: '$2400' },
      { name: 'ROI', value: '12%' },
    ]
  end

  def index
    @sheets = current_user.sheets.order('year desc, title asc')
  end

  def update
  end

  def destroy
  end

  private

  def set_sheet
    @sheet = Sheet.find params[:id]
  end

  def sheet_params
    params.require(:sheet).permit(:title, :year)
  end
end
