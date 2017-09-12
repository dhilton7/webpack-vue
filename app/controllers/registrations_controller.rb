class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  protected

  def sign_up_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end