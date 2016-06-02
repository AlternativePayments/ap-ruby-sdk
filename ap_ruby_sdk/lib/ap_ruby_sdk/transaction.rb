module ApRubySdk
  class Transaction < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::List
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :customer,
                  :customerId,
                  :payment,
                  :token,
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

    def self.retrieve_void(void_id=nil, transaction_id=self.id)
      Void.retrieve(void_id, {}, "#{self.url}/#{transaction_id}")
    end

    def retrieve_void(void_id=nil, transaction_id=self.id)
      self.class.retrieve_void(void_id, transaction_id)
    end

    def self.void(reason='', transaction_id=self.id)
      Void.create({:reason => reason}, "#{self.url}/#{transaction_id}")
    end

    def void(reason='', transaction_id=self.id)
      self.class.void(reason, transaction_id)
    end

    def self.voids(transaction_id=self.id)
      Void.all({}, "#{self.url}/#{transaction_id}")
    end

    def voids(transaction_id=self.id)
      self.class.voids(transaction_id)
    end

    def self.url
      '/transactions'
    end

    def self.list_members
      :transactions
    end
  end
end