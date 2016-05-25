module ApRubySdk
  class Payment < BaseModel

    attr_accessor :paymentOption,
                  :holder,
                  :iban,
                  :bankCode,
                  :documentId,
                  :creditCardNumber,
                  :CVV2,
                  :expirationYear,
                  :expirationMonth,
                  :creditCardType,
                  :bic

  end
end