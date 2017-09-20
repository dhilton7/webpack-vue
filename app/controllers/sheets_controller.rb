class SheetsController < ApplicationController
  before_action :set_sheet, only: %i[show update destroy]

  def create
    @sheet = current_user.sheets.new sheet_params
    if @sheet.save
      render json: { success: true }, status: :created
    else
      render json: { error: @sheet.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: { payload: @sheet }
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
