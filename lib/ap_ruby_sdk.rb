require 'ap_ruby_sdk/version'
require 'base64'
require 'rest_client'
require 'multi_json'

# AP errors
require 'ap_ruby_sdk/errors/ap_error'

# AP operations
require 'ap_ruby_sdk/api_operations/create'
require 'ap_ruby_sdk/api_operations/list'
require 'ap_ruby_sdk/api_operations/retrieve'
# TODO investigate if delete is needed (eg. canceling subscription) or update (eg. change user email)

module ApRubySdk
  @api_base = 'https://api.alternaativepayments.com/api'

  class << self
    attr_accessor :api_key, :api_base, :api_version
  end

  def self.request(method, url, api_key, params={}, headers={})
    unless api_key ||= @api_key
      raise ApError('No API key provided. ') # TODO define API key/Authentication error
    end

    url = api_url(url)

    if method.to_s.downcase.to_sym == :get
      # Make params into GET parameters
      url += "#{URI.parse(url).query ? '&' : '?'}#{uri_encode(params)}" if params && params.any?
      payload = nil
    else
      # Make params inot POST params
      payload = uri_encode(params)
    end

    request_opts = {
        :headers => request_headers(api_key).update(headers),
        :method => method, :open_timeout => 30,
        :payload => payload, :url => url, :timeout => 80
    }

    begin
      response = execute_request(request_opts)
    rescue => e
      put e.message # TODO Handle rest client error and request errors
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
        :authorization => "Basic #{Base64.encode(api_key)}",
        :content_type => 'application/json'
    }
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      response = MultiJson.load(response.body)
    rescue MultiJson::DecodeError
      raise ApError("Invalid response object from API: #{response.body.inspect} " +
                          "(HTTP response code was #{response.code})", response.code) # TODO CHange this into API error
    end

    Util.symbolize_names(response)
  end
end
