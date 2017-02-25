module ApRubySdk
  module Util
    def self.symbolize_names(object)
      case object
        when Hash
          new = {}
          object.each do |key, value|
            key = (key.to_sym rescue key) || key
            new[key] = symbolize_names(value)
          end
          new
        when Array
          object.map { |value| symbolize_names(value) }
        else
          object
      end
    end

    def self.url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.flatten_params(params, parent_key=nil)
      result = []
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{url_encode(key)}]" : url_encode(key)
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end
      result
    end

    def self.flatten_params_array(value, calculated_key)
      result = []
      value.each do |elem|
        if elem.is_a?(Hash)
          result += flatten_params(elem, calculated_key)
        elsif elem.is_a?(Array)
          result += flatten_params_array(elem, calculated_key)
        else
          result << ["#{calculated_key}[]", elem]
        end
      end
      result
    end

    def self.convert_to_ap_object(response, url)
      case response
        when Array
          response.map { |object| convert_to_ap_object(object, url) }
        when Hash
          object_classes.fetch(url, ApiResource).construct_object(response)
        else
          response
      end
    end


    def self.object_classes
      @object_classes ||= {
          '/customers' => Customer,
          '/transactions' => Transaction,
          '/phoneverification' => PhoneVerification,
          '/voids' => Void,
          '/plans' => Plan,
          '/refunds' => Refund,
          '/subscriptions' => Subscription,
          '/preauthorizations' => Preauthorization,
          '/websites' => Website,
          '/paymentoptions' => PaymentOption
      }
    end
  end
end