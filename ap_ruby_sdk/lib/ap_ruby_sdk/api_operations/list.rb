module ApRubySdk
  module ApiOperations
    module List

      module ClassMethods
        def all(pagination_options={}, api_key=nil)
          response = ApRubySdk.request(:get, "#{self.url}/", api_key, pagination_options)
          Util.convert_to_ap_object(response[self.list_members], self.url)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end