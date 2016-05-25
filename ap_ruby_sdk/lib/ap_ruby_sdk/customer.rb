module ApRubySdk
  class Customer < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::List
    include ApRubySdk::ApiOperations::Retrieve

    attr_accessor :firstName,
                  :lastName,
                  :email,
                  :address,
                  :city,
                  :zip,
                  :country,
                  :state,
                  :phone

    def self.url
      '/customers'
    end

    def self.list_members
      :customers
    end
  end
end