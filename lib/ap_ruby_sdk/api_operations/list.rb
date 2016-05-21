module ApRubySdk
  module ApiOperations
    module List

      module ClassMethods
        def all(api_key=nil)
          response = ApRubySdk.request(:get, url, api_key)
          Util.convert_to_ap_object(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end