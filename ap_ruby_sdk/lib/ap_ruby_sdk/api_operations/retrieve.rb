module ApRubySdk
  module ApiOperations
    module Retrieve
      module ClassMethods
        def retrieve(id, retrieve_options={}, url_prefix=nil, api_secret_key=nil, api_public_key=nil)
          response = ApRubySdk.request(:get, "#{url_with_prefix(url_prefix)}/#{id}", api_secret_key, api_public_key, retrieve_options)
          Util.convert_to_ap_object(response, self.url)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end