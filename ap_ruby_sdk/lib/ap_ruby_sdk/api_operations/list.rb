module ApRubySdk
  module ApiOperations
    module List

      module ClassMethods
        def all(api_key=nil)
          response = ApRubySdk.request(:get, self.url, api_key)
          Util.convert_to_ap_object(response, self.url)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end