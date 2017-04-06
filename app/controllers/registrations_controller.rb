class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    resource.build_profile

    yield resource if block_given?

    respond_with resource
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :selected_role, :password, :password_confirmation, :current_password,
                                 profile_attributes: [:first_name, :last_name, :nickname, :location, :website])
  end
end
