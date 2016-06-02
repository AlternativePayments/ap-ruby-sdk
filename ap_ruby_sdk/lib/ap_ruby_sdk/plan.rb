module ApRubySdk
  class Plan < ApiResource
    include ApRubySdk::ApiOperations::Create
    include ApRubySdk::ApiOperations::Retrieve
    include ApRubySdk::ApiOperations::List

    attr_accessor :interval,
                  :period,
                  :amount,
                  :currency,
                  :name,
                  :description

    def self.url
      '/plans'
    end

    def self.list_members
      :plans
    end
  end
end