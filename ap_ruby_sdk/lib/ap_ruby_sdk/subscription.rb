module ApRubySdk
  class Subscription < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::List
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :customer,
                  :customerId,
                  :payment,
                  :paymentId,
                  :plan,
                  :planId,
                  :amount,
                  :isConversionRateFixed,
                  :quantity,
                  :currentBillingCycle,
                  :ipAddress,
                  :status,
                  :phoneverification

    def customer=(customer)
      @customer = Customer.new(customer)
    end

    def payment=(payment)
      @payment = Payment.new(payment)
    end

    def plan=(plan)
      @plan = Plan.new(plan)
    end

    def self.url
      '/subscriptions'
    end

    def self.list_members
      :subscriptions
    end
  end
end