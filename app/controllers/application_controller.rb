# frozen_string_literal: true

class ApplicationController < ActionController::API
  def verify_slack_request
    timestamp = request.headers['X-Slack-Request-Timestamp']
    if (Time.now.to_i - timestamp.to_i).abs > 60 * 5
      head :unauthorized
      return { error: 'Unathorized' }
    end

    sig_basestring = "v0:#{timestamp}:#{request.raw_post}"
    signature =
      'v0=' +
        OpenSSL::HMAC.hexdigest('SHA256', ENV['SIGNING_SECRET'], sig_basestring)
    slack_signature = request.headers['X-Slack-Signature']

    unless ActiveSupport::SecurityUtils.secure_compare(
             signature,
             slack_signature
           )
      head :unauthorized
    end
  end
end
