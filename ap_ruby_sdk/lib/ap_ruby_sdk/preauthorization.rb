module ApRubySdk
  class Preauthorization < ApiResource
    include ApRubySdk::ApiOperations::Create

    attr_accessor :customer,
                  :payment,
                  :amount,
                  :currency

    def customer=(customer)
      @customer = Customer.new(customer)
    end

    def payment=(payment)
      @payment = Payment.new(payment)
    end

    def self.url
      '/preauthorizations'
    end

    def self.list_members
      :preauthorizations
    end
  end
end