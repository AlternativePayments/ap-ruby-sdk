require 'test_helper'

class ErrorHandlingTest < Minitest::Test

  def test_no_api_secret_key_error
    ApRubySdk.api_secret_key = nil

    error = assert_raises ApRubySdk::AuthenticationError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal(error.message, 'No Secret API key provided.')

    ApRubySdk.api_secret_key = 'test'
  end

  def test_no_api_public_key_error
    ApRubySdk.api_public_key = nil

    error = assert_raises ApRubySdk::AuthenticationError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal(error.message, 'No Public API key provided.')

    ApRubySdk.api_public_key = 'public_test'
  end

  def test_payment_error_void_not_supported
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 402, :body => MultiJson.dump(
                                      {
                                          'Type' => 'payment_error',
                                          'Code' => 'void_not_supported',
                                          'StatusCode' => '402',
                                          'Message' => 'Void is not supported'
                                      }))

    error = assert_raises ApRubySdk::PaymentError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('void_not_supported', error.error_code)
    assert_equal('Void is not supported', error.message)
    assert_equal(402, error.http_status)
  end

  def test_payment_error_refund_not_supported
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 402, :body => MultiJson.dump(
                                      {
                                          'Type' => 'payment_error',
                                          'Code' => 'refund_not_supported',
                                          'StatusCode' => '402',
                                          'Message' => 'Refund is not supported'
                                      }))

    error = assert_raises ApRubySdk::PaymentError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('refund_not_supported', error.error_code)
    assert_equal('Refund is not supported', error.message)
    assert_equal(402, error.http_status)
  end

  def test_payment_error_customer_older_than_16
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 402, :body => MultiJson.dump(
                                      {
                                          'Type' => 'payment_error',
                                          'Code' => 'customer_must_be_at_least_16_years_old',
                                          'StatusCode' => '402',
                                          'Message' => 'Customer must be at least 16 years old'
                                      }))

    error = assert_raises ApRubySdk::PaymentError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('customer_must_be_at_least_16_years_old', error.error_code)
    assert_equal('Customer must be at least 16 years old', error.message)
    assert_equal(402, error.http_status)
  end

  def test_payment_error_bank_unknown
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 400, :body => MultiJson.dump(
                                      {
                                          'Type' => 'payment_error',
                                          'Code' => 'bank_unknown',
                                          'StatusCode' => '400',
                                          'Message' => 'Bank unknown.'
                                      }))

    error = assert_raises ApRubySdk::PaymentError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('bank_unknown', error.error_code)
    assert_equal('Bank unknown.', error.message)
    assert_equal(400, error.http_status)
  end

  def test_api_error
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 402, :body => MultiJson.dump(
                                      {
                                          'Type' => 'api_error',
                                          'Code' => 'api_error',
                                          'StatusCode' => '402',
                                          'Message' => 'Api Error'
                                      }))

    error = assert_raises ApRubySdk::APIError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('api_error', error.error_code)
    assert_equal('Api Error', error.message)
    assert_equal(402, error.http_status)
  end

  def test_acquirer_down
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 402, :body => MultiJson.dump(
                                      {
                                          'Type' => 'acquirer_down',
                                          'Code' => 'acquirer_down',
                                          'StatusCode' => '402',
                                          'Message' => 'Acquirer Down'
                                      }))

    error = assert_raises ApRubySdk::APIError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('acquirer_down', error.error_code)
    assert_equal('Acquirer Down', error.message)
    assert_equal(402, error.http_status)
  end

  def test_not_found
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 404, :body => MultiJson.dump(
                                      {
                                          'Type' => 'api_error',
                                          'Code' => 'not_found',
                                          'StatusCode' => '404',
                                          'Message' => 'Not Found - The requested item doesn’t exist.'
                                      }))

    error = assert_raises ApRubySdk::APIError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('not_found', error.error_code)
    assert_equal('Not Found - The requested item doesn’t exist.', error.message)
    assert_equal(404, error.http_status)
  end

  def test_internal_server_error
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 500, :body => MultiJson.dump(
                                      {
                                          'Type' => 'api_error',
                                          'Code' => 'internal_server_error',
                                          'StatusCode' => '500',
                                          'Message' => 'Server errors - internal server error.'
                                      }))

    error = assert_raises ApRubySdk::APIError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('internal_server_error', error.error_code)
    assert_equal('Server errors - internal server error.', error.message)
    assert_equal(500, error.http_status)
  end

  def test_invalid_object_sent
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 400, :body => MultiJson.dump(
                                      {
                                          'Type' => 'invalid_parameter_error',
                                          'Code' => 'invalid_object_sent',
                                          'StatusCode' => '400',
                                          'Message' => 'Object is not sent or invalid object is sent',
                                          'Param' => 'id'
                                      }))

    error = assert_raises ApRubySdk::InvalidParameterError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('invalid_object_sent', error.error_code)
    assert_equal('Object is not sent or invalid object is sent', error.message)
    assert_equal('id', error.parameter)
    assert_equal(400, error.http_status)
  end

  def test_invalid_api_secret_key
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 401, :body => MultiJson.dump(
                                      {
                                          'Type' => 'invalid_parameter_error',
                                          'Code' => 'invalid_api_keys',
                                          'StatusCode' => '401',
                                          'Message' => "Invalid API key #{Base64.encode64(ApRubySdk.api_secret_key)}",
                                          'Param' => 'api_key'
                                      }))

    error = assert_raises ApRubySdk::InvalidParameterError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('invalid_api_keys', error.error_code)
    assert_equal("Invalid API key #{Base64.encode64(ApRubySdk.api_secret_key)}", error.message)
    assert_equal('api_key', error.parameter)
    assert_equal(401, error.http_status)
  end

  def test_information_on_black_list
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 400, :body => MultiJson.dump(
                                      {
                                          'Type' => 'invalid_parameter_error',
                                          'Code' => 'information_on_black_list',
                                          'StatusCode' => '400',
                                          'Message' => 'Information sent on the transaction are found on the blacklist',
                                          'Param' => 'transaction'
                                      }))

    error = assert_raises ApRubySdk::InvalidParameterError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('information_on_black_list', error.error_code)
    assert_equal('Information sent on the transaction are found on the blacklist', error.message)
    assert_equal('transaction', error.parameter)
    assert_equal(400, error.http_status)
  end

  def test_payment_option_is_not_active
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 503, :body => MultiJson.dump(
                                      {
                                          'Type' => 'invalid_parameter_error',
                                          'Code' => 'payment_option_is_not_active',
                                          'StatusCode' => '503',
                                          'Message' => 'Payment option is not active.',
                                          'Param' => 'payment'
                                      }))

    error = assert_raises ApRubySdk::InvalidParameterError do
      ApRubySdk::Customer.retrieve('123')
    end

    assert_equal('payment_option_is_not_active', error.error_code)
    assert_equal('Payment option is not active.', error.message)
    assert_equal('payment', error.parameter)
    assert_equal(503, error.http_status)
  end
end