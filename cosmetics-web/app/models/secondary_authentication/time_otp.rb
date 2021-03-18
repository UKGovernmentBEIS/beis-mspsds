module SecondaryAuthentication
  class TimeOtp
    DRIFT_BEHIND_SECONDS = 15 # Seconds where previous TOTP code will still be valid after a new one has been generated.
    QR_SIZE_PX = 200
    OTP_LENGTH = 6
    SUBMIT_ISSUER = "Submit Cosmetics".freeze
    SEARCH_ISSUER = "Search Cosmetics".freeze

    attr_accessor :user, :last_totp_at, :secret_key

    def initialize(user, secret_key: nil)
      @user = user
      @secret_key = (secret_key.presence || user.totp_secret_key.presence || self.class.generate_secret_key)
    end

    def qr_code
      RQRCode::QRCode
        .new(totp.provisioning_uri(user.email))
        .as_png(resize_exactly_to: QR_SIZE_PX)
        .to_data_url
    end

    def valid_otp?(otp)
      return false if otp.blank?

      @last_totp_at = totp.verify(otp.strip, drift_behind: DRIFT_BEHIND_SECONDS)
      @last_totp_at.present?
    end

    def self.generate_secret_key
      ROTP::Base32.random
    end

  private

    def totp
      @totp ||= ROTP::TOTP.new(@secret_key, issuer: totp_issuer)
    end

    def totp_issuer
      user.is_a?(SearchUser) ? SEARCH_ISSUER : SUBMIT_ISSUER
    end
  end
end
