class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  clear_respond_to
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