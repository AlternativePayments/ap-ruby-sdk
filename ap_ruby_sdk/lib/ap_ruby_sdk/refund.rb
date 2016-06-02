module ApRubySdk
  class Refund < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::Retrieve
    include ApRubySdk::ApiOperations::List

    attr_accessor :amount,
                  :currency,
                  :originalTransactionId,
                  :originalTransaction,
                  :status,
                  :reason

    def originalTransaction=(originalTransaction)
      @originalTransaction = Transaction.new(originalTransaction)
    end

    def self.url
      '/refunds'
    end

    def self.list_members
      :refundTransactions
    end
  end
end