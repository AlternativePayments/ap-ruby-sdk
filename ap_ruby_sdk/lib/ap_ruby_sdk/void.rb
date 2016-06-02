module ApRubySdk
  class Void < ApiResource
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
      '/voids'
    end

    def self.list_members
      :voidTransactions
    end
  end
end