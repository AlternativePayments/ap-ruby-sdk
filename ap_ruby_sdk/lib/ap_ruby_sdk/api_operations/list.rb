module ApRubySdk
  module ApiOperations
    module List
      module ClassMethods
        def all(pagination_options={}, url_prefix=nil, api_secret_key=nil, api_public_key=nil)
          response = ApRubySdk.request(:get, "#{url_with_prefix(url_prefix)}/", api_secret_key, api_public_key, pagination_options)
          list = Util.convert_to_ap_object(response[self.list_members], self.url)
          ApRubySdk::Collection.new(
              'items' => list,
              'pagination' => response[:pagination]
          )
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end