module ApRubySdk
  class PhoneVerification < ApiResource
    include ApRubySdk::ApiOperations::Create

    attr_accessor :key,
                  :phone,
                  :type,
                  :token,
                  :pin

    def self.url
      '/phoneverification'
    end
  end
end