module ApRubySdk
  module ApiOperations
    module Create

      module ClassMethods
        def create(params={}, api_key=nil)
          response = ApRubySdk.request(:post, self.url, api_key, params)
          Util.convert_to_ap_object(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end

  end
end