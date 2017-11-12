module ApRubySdk
  class HostedTransaction < Transaction

    def self.url
      '/transactions/hosted'
    end

    def self.list_members
      :transactions
    end
  end
end