require 'action_controller'

module DeviceAutoSignOut
  module ActionControllerExtension

    private

    def session_auto_expire
      if current_user.present?
        DeviceAutoSignOut::CheckSession.new(self).call
      end
    end
  end
end

ActionController::Base.send :include, DeviceAutoSignOut::ActionControllerExtension