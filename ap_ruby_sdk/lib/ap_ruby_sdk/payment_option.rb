module ApRubySdk
  class PaymentOption < ApiResource
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :hasSmsVerification,
                  :url

    def self.url
      '/paymentoptions'
    end

    def self.list_members
      :paymentoptions
    end
  end
end