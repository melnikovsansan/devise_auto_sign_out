require 'action_controller'

module DeviceAutoSignOut
  module ActionControllerExtension

    private

    def session_auto_expire
      if current_user.present?
        offset = current_user.try(:timeout_in)
        if offset && offset > 0
          is_active_action = request.original_url.start_with?(account_active_url)
          expires_at = session[:auto_session_expires_at]
          if expires_at.present? && expires_at < (offset / 10).seconds.since
            if is_active_action
              reset_session
              sign_out(:user) if signed_in?(:user)
              URI(request.referer).tap do |referer_uri|
                referer_uri.host = referer_uri.scheme = referer_uri.port = nil
                session[:user_return_to] = referer_uri.to_s
              end
              flash[:alert] = I18n.t('devise.failure.timeout')
            else
              session[:auto_session_expires_at] = Time.now + offset
            end
          end
        end
      end
    end
  end
end

ActionController::Base.send :include, DeviceAutoSignOut::ActionControllerExtension