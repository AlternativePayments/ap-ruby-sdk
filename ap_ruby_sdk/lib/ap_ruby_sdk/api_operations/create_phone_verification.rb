module ApRubySdk
  module ApiOperations
    module CreatePhoneVerification
      module ClassMethods
        def create_phone_verification(params={}, url_prefix=nil, api_secret_key=nil, api_public_key=nil)
          api_public_key ||= ApRubySdk.api_public_key

          params.update({
            :key => api_public_key
          })

          response = ApRubySdk.request(:post, url_with_prefix(url_prefix), api_secret_key, api_public_key, params)
          Util.convert_to_ap_object(response, self.url)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end