class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @user = User.find_by_email(google_authenticated_email)

    if @user.present?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure', kind: 'Google')
      redirect_to root_path
    end
  end

  protected
  def google_authenticated_data
    request.env['omniauth.auth']
  end

  def google_authenticated_email
    google_authenticated_data.fetch(:info).fetch(:email).downcase
  end
end
