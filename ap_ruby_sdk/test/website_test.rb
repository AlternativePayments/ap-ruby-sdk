require 'test_helper'

class WebsiteTest < Minitest::Test

  def test_is_phone_verification_on
    stub_request(:get, 'https://api.alternativepayments.com/api/websites/' + ApRubySdk.api_public_key + '/paymentoptions/SEPA').
        with(
            body: {},
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'id' => 'web_6547gfhu67yrru43',
                                          'mode' => 'Test',
                                          'hasSmsVerification' => true,
                                          'url' => 'http://www.mywebshop.com'
                                      },
                                      :headers => {}))

    payment_option = ApRubySdk::Website.is_phone_verification_on('SEPA')

    assert_equal('Test', payment_option.mode)
    assert_equal(true, payment_option.hasSmsVerification)
    assert_equal('http://www.mywebshop.com', payment_option.url)
  end
end