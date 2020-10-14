# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.lograge.enabled = Rails.env.production?

  config.lograge.custom_payload do |controller|
    extra_payload = {}
    extra_payload[:user_id] = controller.current_user&.id rescue nil
    extra_payload
  end
end
