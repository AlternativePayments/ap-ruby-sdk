require 'test_helper'

class PhoneVerificationTest < Minitest::Test

  def test_create_phone_verification
    stub_request(:post, 'https://api.alternativepayments.com/api/phoneverification').
        with(
            body: '{'\
                    '"phone":"+15555555555"'\
                '}',
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'mode' => 'Live',
                                          'type' => 'SMS',
                                          'phone' => '15555555555',
                                          'token' => '8b340ecdfc63ccccccc1fe59310',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    phoneVerification = ApRubySdk::PhoneVerification.create(
        'phone' => '+15555555555'
    )

    assert_equal('Live', phoneVerification.mode)
    assert_equal('SMS', phoneVerification.type)
    assert_equal('15555555555', phoneVerification.phone)
    assert_equal('8b340ecdfc63ccccccc1fe59310', phoneVerification.token)
    assert_equal('2016-03-24T15:19:10.7800694Z', phoneVerification.created)
  end

  def test_create_phone_verification_operation
    stub_request(:post, 'https://api.alternativepayments.com/api/phoneverification').
        with(
            body: '{'\
                    '"phone":"+15555555555",'\
                    '"key":"public_test"'\
                '}',
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'mode' => 'Live',
                                          'type' => 'SMS',
                                          'phone' => '15555555555',
                                          'token' => '8b340ecdfc63ccccccc1fe59310',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    phoneVerification = ApRubySdk::PhoneVerification.create_phone_verification(
        'phone' => '+15555555555'
    )

    assert_equal('Live', phoneVerification.mode)
    assert_equal('SMS', phoneVerification.type)
    assert_equal('15555555555', phoneVerification.phone)
    assert_equal('8b340ecdfc63ccccccc1fe59310', phoneVerification.token)
    assert_equal('2016-03-24T15:19:10.7800694Z', phoneVerification.created)
  end


end