class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show update destroy]
  respond_to :json

  def show
  end

  def index
    @properties = current_user.properties
  end

  def create
    @property = Property.new property_params.merge!(user_id: current_user.id)
    if @property.save
      render json: { payload: @property.to_builder, status: :created }
    else
      render json: { error: @property.errors.messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: { payload: @property, status: :updated }
    else
      render json: { error: @property.errors.messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    render json: { success: true, status: :deleted }
  end

  private

  def set_property
    @property = Property.find params[:id]
  end

  def property_params
    params.require(:property).permit(:address, :city, :state, :zip, :status, :notes)
  end
end
