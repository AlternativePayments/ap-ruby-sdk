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
                  :status

    def customer=(customer)
      @customer = Customer.new(customer)
    end

    def self.url
      '/transactions'
    end

    def self.list_members
      :transactions
    end
  end
end