module ApRubySdk
  class Customer < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::List
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :firstName,
                  :lastName,
                  :email,
                  :address,
                  :address2,
                  :city,
                  :zip,
                  :country,
                  :state,
                  :phone,
                  :birthDate

    def self.url
      '/customers'
    end

    def self.list_members
      :customers
    end
  end
end