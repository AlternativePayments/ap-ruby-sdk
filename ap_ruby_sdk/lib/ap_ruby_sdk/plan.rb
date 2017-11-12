module ApRubySdk
  class Plan < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::Retrieve
    include ApRubySdk::ApiOperations::List

    attr_accessor :name,
                  :description,
                  :amount,
                  :currency,
                  :intervalUnit,
                  :intervalCount,
                  :billingCycles,
                  :isConversionRateFixed,
                  :ipAddress,
                  :trialPeriod,
                  :cancelSubscriptions


    def self.url
      '/plans'
    end

    def self.list_members
      :plans
    end
  end
end