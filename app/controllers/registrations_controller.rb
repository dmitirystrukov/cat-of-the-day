class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.add_role(sign_up_params[:selected_role])
    resource.save

    yield resource if block_given?

    if resource.persisted?
      resource.create_profile(profile_params)

      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :selected_role, :password, :password_confirmation, :current_password)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :website)
  end
end
