require 'devise_auto_sign_out/version'
require 'rails'
require 'devise_auto_sign_out/action_controller_extension'
require 'devise_auto_sign_out/session_controller_extension'

module DeviseAutoSignOut
  class Engine < Rails::Engine
  end
end
