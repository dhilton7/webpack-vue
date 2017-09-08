class RegistrationsController < Devise::RegistrationsController
  respond_to :json


  def create
    u = User.create(user_params)
    if u.save
      render json: { success: true }, status: 201
    else
      render json: { errors: 'meow' }, status: 422
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end