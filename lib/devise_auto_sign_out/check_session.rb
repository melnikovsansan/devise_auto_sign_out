require 'action_controller'

module DeviceAutoSignOut
  class CheckSession

    attr_reader :controller

    delegate :current_user, :request, :account_active_url, :session, :sign_out, :signed_in?, :reset_session,
             :flash, to: :@controller

    def initialize(controller)
      @controller = controller
    end

    def call
      if !active_action?
        prolong_session!
      elsif soon_expire?
        reset_session!
      end
    end

    private

    def prolong_session!
      session[:auto_session_expires_at] = Time.current + offset.seconds
    end

    def reset_session!
      reset_session
      sign_out(:user) if signed_in?(:user)
      set_user_return_to_referrer if request.referrer
      flash[:alert] = I18n.t('devise.failure.timeout')
    end

    def set_user_return_to_referrer
      URI(request.referer).tap do |referer_uri|
        referer_uri.host = referer_uri.scheme = referer_uri.port = nil
        session[:user_return_to] = referer_uri.to_s
      end
    end

    def offset
      current_user.timeout_in if current_user
    end

    def active_action?
      request.original_url.start_with?(account_active_url)
    end

    def expires_at
      session[:auto_session_expires_at]
    end

    def soon_expire?
      offset && offset > 0 && expires_at.present? && expires_at < Time.current + 1.minute
    end
  end
end