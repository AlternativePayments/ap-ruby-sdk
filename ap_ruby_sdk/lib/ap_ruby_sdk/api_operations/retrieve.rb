module ApRubySdk
  module ApiOperations
    module Retrieve

      module ClassMethods
        def retrieve(api_key=nil, retrieve_options={})
          response = ApRubySdk.request(:get, self.url, api_key, retrieve_options)
          Util.convert_to_ap_object(response, self.url)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end