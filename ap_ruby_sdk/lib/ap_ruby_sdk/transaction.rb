module ApRubySdk
  class Transaction < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::List
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :customer,
                  :customerId,
                  :payment,
                  :phoneVerification,
                  :amount,
                  :currency,
                  :merchantPassThruData,
                  :merchantTransactionId,
                  :description,
                  :ipAddress,
                  :status,
                  :redirectUrls,
                  :redirectUrl,
                  :phoneverification

    def customer=(customer)
      @customer = Customer.new(customer)
    end

    def payment=(payment)
      @payment = Payment.new(payment)
    end

    def redirectUrls=(redirectUrls)
      @redirectUrls = RedirectUrls.new(redirectUrls)
    end

    def phoneverification=(phoneverification)
      @phoneverification = PhoneVerification.new(phoneverification)
    end

    def self.url
      '/transactions'
    end

    def self.list_members
      :transactions
    end
  end
end