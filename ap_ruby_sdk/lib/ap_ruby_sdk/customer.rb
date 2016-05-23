module ApRubySdk
  class Customer < ApiResource
    include ApRubySdk::ApiOperations::Create

    attr_accessor :firstName,
                  :lastName,
                  :email,
                  :address,
                  :city,
                  :zip,
                  :country,
                  :state,
                  :phone

    def payment(payment)
      @payment = Payment.new(payment)
    end

    def self.url
      '/customers'
    end
  end
end