class PropertiesController < ApplicationController
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

  private

  def property_params
    params.require(:property).permit(:address, :city, :state, :zip, :status, :notes)
  end
end
