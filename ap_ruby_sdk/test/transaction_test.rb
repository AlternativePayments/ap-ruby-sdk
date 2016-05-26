require 'test_helper'

class TransactionTest < Minitest::Test

  def test_create_sepa_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: '{'\
                    '"customer":{'\
                      '"id":"cus_bd838e3611d34d598",'\
                      '"firstName":"John",'\
                      '"lastName":"Doe",'\
                      '"email":"john@doe.com",'\
                      '"country":"DE"'\
                    '},'\
                    '"payment":{'\
                      '"paymentOption":"SEPA",'\
                      '"holder":"John Doe",'\
                      '"iban":"DE71XXXXX3330"'\
                    '},'\
                     '"amount":500,'\
                    '"currency":"EUR"'\
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
                                          'id' => 'trn_d12209838b',
                                          'mode' => 'Live',
                                          'status' => 'Pending',
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

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR'
    )

    assert_equal('trn_d12209838b', transaction.id)
    assert_equal('Live', transaction.mode)
    assert_equal(customer.id, transaction.customer.id)
    assert_equal('Live', transaction.customer.mode)
    assert_equal(customer.firstName, transaction.customer.firstName)
    assert_equal(customer.lastName, transaction.customer.lastName)
    assert_equal(customer.email, transaction.customer.email)
    assert_equal(customer.country, transaction.customer.country)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.customer.created)
    assert_equal('pay_ffd25121f84e4d249', transaction.payment.id)
    assert_equal('Live', transaction.payment.mode)
    assert_equal(payment.holder, transaction.payment.holder)
    assert_equal(payment.paymentOption, transaction.payment.paymentOption)
    assert_equal(payment.iban, transaction.payment.iban)
    assert_equal(500, transaction.amount)
    assert_equal('EUR', transaction.currency)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.created)
  end

  def test_create_mistercash_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: '{'\
                    '"customer":{'\
                      '"id":"cus_bd838e3611d34d598",'\
                      '"firstName":"John",'\
                      '"lastName":"Doe",'\
                      '"email":"john@doe.com",'\
                      '"country":"DE"'\
                    '},'\
                    '"payment":{'\
                      '"paymentOption":"mistercash",'\
                      '"holder":"John Doe"'\
                    '},'\
                     '"amount":500,'\
                    '"currency":"EUR",'\
                    '"redirectUrls":{'\
                      '"returnUrl":"http://plugins.alternativepayments.com/message/success.html",'\
                      '"cancelUrl":"http://plugins.alternativepayments.com/message/failure.html"'\
                    '}'\
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
            'id' => 'trn_d12209838b',
            'mode' => 'Live',
            'status' => 'Pending',
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
                'paymentOption' => 'mistercash'
            },
            'amount' => 500,
            'currency' => 'EUR',
            'merchantPassThruData'=> 'Order #1234958',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
              'returnUrl'=> 'http://plugins.alternativepayments.com/message/success.html',
              'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            },
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
        'paymentOption' => 'mistercash',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'redirectUrls' => redirectUrls
    )

    assert_equal('trn_d12209838b', transaction.id)
    assert_equal('Live', transaction.mode)
    assert_equal(customer.id, transaction.customer.id)
    assert_equal('Live', transaction.customer.mode)
    assert_equal(customer.firstName, transaction.customer.firstName)
    assert_equal(customer.lastName, transaction.customer.lastName)
    assert_equal(customer.email, transaction.customer.email)
    assert_equal(customer.country, transaction.customer.country)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.customer.created)
    assert_equal('pay_ffd25121f84e4d249', transaction.payment.id)
    assert_equal('Live', transaction.payment.mode)
    assert_equal(payment.holder, transaction.payment.holder)
    assert_equal(payment.paymentOption, transaction.payment.paymentOption)
    assert_equal(payment.iban, transaction.payment.iban)
    assert_equal(redirectUrls.returnUrl, transaction.redirectUrls.returnUrl)
    assert_equal(redirectUrls.cancelUrl, transaction.redirectUrls.cancelUrl)
    assert_equal(500, transaction.amount)
    assert_equal('EUR', transaction.currency)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.created)
  end

end