class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  protected

  def sign_up_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end