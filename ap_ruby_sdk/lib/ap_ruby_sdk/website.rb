module ApRubySdk
  class Website < ApiResource

    def self.is_phone_verification_on(payment_option=nil)
      PaymentOption.retrieve(payment_option, {}, "#{self.url}/#{ApRubySdk.api_public_key}")
    end

    def is_phone_verification_on(payment_option=nil)
      self.is_phone_verification_on(payment_option)
    end

    def self.url
      '/websites'
    end
  end
end