require 'test_helper'

class PreauthorizationTest < Minitest::Test

  def test_create_sepa_preauthorization
    stub_request(:post, 'https://api.alternativepayments.com/api/preauthorizations').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'SEPA',
                         holder: 'John Doe',
                         iban: 'DE71XXXXX3330'
                     }
                }),
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'id' => 'preauth_ee146f5315',
                                          'mode' => 'Live',
                                          'status' => 'Approved',
                                          'customer' => {
                                              'id' => 'cus_bd838e3611d34d598',
                                              'mode' => 'Live',
                                              'firstName' => 'John',
                                              'lastName' => 'Doe',
                                              'email' => 'john@doe.com',
                                              'country' => 'DE',
                                              'created' => '2016-03-24T15:19:10.7800694Z'
                                          },
                                          'payment' => {
                                              'id' => 'pay_ffd25121f84e4d249',
                                              'mode' => 'Live',
                                              'holder' => 'John Doe',
                                              'paymentOption' => 'SEPA',
                                              'iban' => 'DE71XXXXX3330'
                                          },
                                          'amount' => 500,
                                          'currency' => 'EUR',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'iban' => 'DE71XXXXX3330'
    )

    preauthorization = ApRubySdk::Preauthorization.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR'
    )

    assert_equal('preauth_ee146f5315', preauthorization.id)
    assert_equal('Live', preauthorization.mode)
    assert_equal(customer.id, preauthorization.customer.id)
    assert_equal('Live', preauthorization.customer.mode)
    assert_equal(customer.firstName, preauthorization.customer.firstName)
    assert_equal(customer.lastName, preauthorization.customer.lastName)
    assert_equal(customer.email, preauthorization.customer.email)
    assert_equal(customer.country, preauthorization.customer.country)
    assert_equal('2016-03-24T15:19:10.7800694Z', preauthorization.customer.created)
    assert_equal('pay_ffd25121f84e4d249', preauthorization.payment.id)
    assert_equal('Live', preauthorization.payment.mode)
    assert_equal(payment.holder, preauthorization.payment.holder)
    assert_equal(payment.paymentOption, preauthorization.payment.paymentOption)
    assert_equal(payment.iban, preauthorization.payment.iban)
    assert_equal(500, preauthorization.amount)
    assert_equal('EUR', preauthorization.currency)
    assert_equal('2016-03-24T15:19:10.7800694Z', preauthorization.created)
  end

end