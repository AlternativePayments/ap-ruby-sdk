require 'base64'
require 'rest-client'
require 'oj'
require 'multi_json'

# Version
require 'ap_ruby_sdk/version'

# AP errors
require 'ap_ruby_sdk/errors/ap_error'
require 'ap_ruby_sdk/errors/api_error'
require 'ap_ruby_sdk/errors/authentication_error'
require 'ap_ruby_sdk/errors/invalid_parameter_error'
require 'ap_ruby_sdk/errors/payment_error'

# AP operations
require 'ap_ruby_sdk/api_operations/create'
require 'ap_ruby_sdk/api_operations/list'
require 'ap_ruby_sdk/api_operations/retrieve'

# AP Resources
require 'ap_ruby_sdk/util'
require 'ap_ruby_sdk/base_model'
require 'ap_ruby_sdk/api_resource'
require 'ap_ruby_sdk/customer'
require 'ap_ruby_sdk/payment'
require 'ap_ruby_sdk/transaction'
require 'ap_ruby_sdk/void'
require 'ap_ruby_sdk/refund'
require 'ap_ruby_sdk/redirect_urls'
require 'ap_ruby_sdk/phone_verification'

module ApRubySdk
  @api_base = 'https://api.alternativepayments.com/api'

  class << self
    attr_accessor :api_key, :api_base
  end

  def self.request(method, url, api_key, params={}, headers={})
    unless api_key ||= @api_key
      raise AuthenticationError.new('No API key provided.')
    end

    url = api_url(url)

    if method.to_s.downcase.to_sym == :get
      # Make params into GET params
      url += "#{URI.parse(url).query ? '&' : '?'}#{uri_encode(params)}" if params && params.any?
      payload = nil
    elsif method.to_s.downcase.to_sym == :delete
      # Make params into expected DELETE params
    elsif method.to_s.downcase.to_sym == :put
      # Make params into expected PUT params
    else
      # Make params into POST params
      payload = MultiJson.dump(params, mode: :compat)
    end

    request_opts = {
        :headers => request_headers(api_key).update(headers),
        :open_timeout => 30,
        :timeout => 80,
        :method => method,
        :payload => payload,
        :url => url
    }
    begin
      response = execute_request(request_opts)
    rescue RestClient::ExceptionWithResponse => e
      if e.http_code and e.http_body
        parse_api_error(e.http_code, e.http_body)
      else
        raise APIError.new(message + "\n\n(Network error: #{e.message})")
      end
    end

    parse(response)
  end

  def self.api_url(url='')
    @api_base + url
  end

  private

  def self.uri_encode(params)
    Util.flatten_params(params).
        map { |k, v| "#{k}=#{Util.url_encode(v)}" }.join('&')
  end

  def self.request_headers(api_key)
    {
        :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}",
        :authorization => "Basic #{Base64.strict_encode64(api_key)}",
        :content_type => :json
    }
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      response = MultiJson.load(response.body)
    rescue MultiJson::DecodeError
      raise_general_error(response.code, response.body)
    end

    Util.symbolize_names(response)
  end

  def self.raise_general_error(response_code, response_body)
    raise APIError.new("Invalid response object from API: #{response_body.inspect} " +
                           "(HTTP response code was #{response_code})", response_code)
  end

  def self.parse_api_error(response_code, response_body)
    begin
      error = MultiJson.load(response_body)
      error = Util.symbolize_names(error)

      raise ApError.new if error[:Type].nil? # if there is no type

    rescue MultiJson::DecodeError, ApError
      raise_general_error(response_code, response_body)
    end

    case error[:Type]
      when 'payment_error'
        raise PaymentError.new(error[:Message], response_code, error[:Code])
      when 'api_error'
        raise APIError.new(error[:Message], response_code, error[:Code])
      when 'invalid_parameter_error'
        raise InvalidParameterError.new(error[:Message], response_code, error[:Code], error[:Param])
      else
        raise APIError.new(error[:Message], response_code, error[:Code]);
    end
  end
end
