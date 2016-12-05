module DeviceAutoSignOut
  module SessionControllerExtension
    def active
      response.headers['Etag'] = '' # clear etags to prevent caching
      render text: signed_in?(resource).to_s, status: 200
    end
  end
end