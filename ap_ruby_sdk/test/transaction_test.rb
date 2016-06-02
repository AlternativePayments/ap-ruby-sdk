require 'test_helper'

class TransactionTest < Minitest::Test

  def test_create_sepa_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including({payment: {paymentOption: 'SEPA', holder: 'John Doe', iban: 'DE71XXXXX3330'}}),
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
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'mistercash',
                         holder: 'John Doe'
                     }
                }
            ),
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

  def test_create_ideal_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'ideal',
                         holder: 'John Doe',
                         bankCode: 'ABN_AMRO'
                     }
                }
            ),
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
                'paymentOption' => 'ideal',
                'bankCode' => 'ABN_AMRO',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 500,
            'currency' => 'EUR',
            'merchantPassThruData' => 'Order #1234958',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'returnUrl'=> 'http://plugins.alternativepayments.com/message/success.html',
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            },
            'ipAddress' => '89.216.124.9',
            'redirectUrl' => 'http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97',
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
        'paymentOption' => 'ideal',
        'holder' => 'John Doe',
        'bankCode' => 'ABN_AMRO'
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
    assert_equal(500, transaction.amount)
    assert_equal('EUR', transaction.currency)
    assert_equal('89.216.124.9', transaction.ipAddress)
    assert_equal('http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97', transaction.redirectUrl)
  end

  def test_create_brazil_pay_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'BrazilPayBankTransfer',
                         holder: 'John Doe',
                         bankCode: 'hsbc',
                         documentId: '853.513.468-93',
                     }
                }
            ),
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
                'address' => 'Rua E',
                'address2' => '1040',
                'city' => 'Maracanaú',
                'zip' => '61919-230',
                'country' => 'BR',
                'state' => 'CE',
                'phone' => '+55A7xxxxxxx',
                'birthDate' => '12/04/1979',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'BrazilPayBankTransfer',
                'bankCode' => 'hsbc',
                'documentId' => '853.513.468-93',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 100,
            'currency' => 'EUR',
            'merchantPassThruData' => 'Order #1234958',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'returnUrl'=> 'http://plugins.alternativepayments.com/message/success.html',
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            },
            'ipAddress' => '89.216.124.9',
            'redirectUrl' => 'http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97',
        },
        :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'address' => 'Rua E',
        'address2' => '1040',
        'city' => 'Maracanaú',
        'zip' => '61919-230',
        'country' => 'BR',
        'state' => 'CE',
        'phone' => '+55A7xxxxxxx',
        'birthDate' => '12/04/1979'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'BrazilPayBankTransfer',
        'holder' => 'John Doe',
        'bankCode' => 'hsbc',
        'documentId' => '853.513.468-93'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 100,
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
    assert_equal(customer.address, transaction.customer.address)
    assert_equal(customer.address2, transaction.customer.address2)
    assert_equal(customer.country, transaction.customer.country)
    assert_equal(customer.city, transaction.customer.city)
    assert_equal(customer.state, transaction.customer.state)
    assert_equal(customer.zip, transaction.customer.zip)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.customer.created)
    assert_equal('pay_ffd25121f84e4d249', transaction.payment.id)
    assert_equal('Live', transaction.payment.mode)
    assert_equal(payment.holder, transaction.payment.holder)
    assert_equal(payment.paymentOption, transaction.payment.paymentOption)
    assert_equal(payment.documentId, transaction.payment.documentId)
    assert_equal(payment.bankCode, transaction.payment.bankCode)
    assert_equal(100, transaction.amount)
    assert_equal('EUR', transaction.currency)
    assert_equal('89.216.124.9', transaction.ipAddress)
    assert_equal('http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97', transaction.redirectUrl)
  end

  def test_create_credit_card_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'CreditCard',
                         holder: 'John Doe',
                         creditCardNumber: '4111111111111111',
                         CVV2: '222',
                         creditCardType: 'visa',
                         expirationYear: 2019,
                         expirationMonth: 12,
                     }
                }
            ),
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
            'status' => 'Funded',
            'customer' => {
                'id' => 'cus_bd838e3611d34d598',
                'mode' => 'Live',
                'firstName' => 'John',
                'lastName' => 'Doe',
                'email' => 'john@doe.com',
                'country' => 'US',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'CreditCard',
                'creditCardNumber' => 'XXXXXXXXXXX1111',
                'creditCardType' => 'visa',
                'expirationMonth' => 12,
                'expirationYear' => 2019,
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 1500,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z'
        },
        :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'US'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'CreditCard',
        'holder' => 'John Doe',
        'creditCardNumber' => '4111111111111111',
        'CVV2' => '222',
        'creditCardType' => 'visa',
        'expirationMonth' => 12,
        'expirationYear' => 2019
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 1500,
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
    assert_equal('XXXXXXXXXXX1111', transaction.payment.creditCardNumber)
    assert_equal(payment.creditCardType, transaction.payment.creditCardType)
    assert_equal(payment.expirationMonth, transaction.payment.expirationMonth)
    assert_equal(payment.expirationYear, transaction.payment.expirationYear)
    assert_equal(1500, transaction.amount)
    assert_equal('EUR', transaction.currency)
  end

  def test_create_giropay_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'Giropay',
                         holder: 'John Doe',
                         bic: 'TESTDETT421'
                     }
                }
            ),
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
            'status' => 'Funded',
            'customer' => {
                'id' => 'cus_bd838e3611d34d598',
                'mode' => 'Live',
                'firstName' => 'John',
                'lastName' => 'Doe',
                'email' => 'john@doe.com',
                'country' => 'US',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'Giropay',
                'bic' => 'TESTDETT421',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 1500,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            }
        },
        :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'US'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'Giropay',
        'holder' => 'John Doe',
        'bic' => 'TESTDETT421'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 1500,
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
    assert_equal(payment.bic, transaction.payment.bic)
    assert_equal(1500, transaction.amount)
    assert_equal('EUR', transaction.currency)
  end

  def test_create_directpay_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'directpay',
                         holder: 'John Doe'
                     }
                }
            ),
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
                'country' => 'US',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'directpay',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 1500,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'returnUrl'=> 'http://plugins.alternativepayments.com/message/success.html',
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            },
            'ipAddress' => '89.216.124.9',
            'redirectUrl' => 'http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97'
        },
        :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'US'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'directpay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 1500,
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
    assert_equal(1500, transaction.amount)
    assert_equal('EUR', transaction.currency)
  end

  def test_create_directpay_max_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {payment:
                     {
                         paymentOption: 'directpaymax',
                         holder: 'John Doe',
                         bankCode: 'POSTBANK'
                     }
                }
            ),
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
                'country' => 'US',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'directpaymax',
                'bankCode' => 'POSTBANK',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 1500,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'returnUrl'=> 'http://plugins.alternativepayments.com/message/success.html',
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            },
            'ipAddress' => '89.216.124.9',
            'redirectUrl' => 'http://mybankingsite.com/hRedirection.aspx?transaction_id=trn_1a5f5e0c97'
        },
        :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'US'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'directpaymax',
        'holder' => 'John Doe',
        'bankCode' => 'POSTBANK'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 1500,
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
    assert_equal(payment.bankCode, transaction.payment.bankCode)
    assert_equal(1500, transaction.amount)
    assert_equal('EUR', transaction.currency)
  end

  def test_create_transaction_using_token_and_pin
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: hash_including(
                {
                    phoneverification:
                        {
                            token: '8b340ecdfc63ccccccc1fe59310',
                            pin: '6010'
                        }
                }
            ),
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
                'iban' => 'DE71XXXXX3330',
                'created' => '2016-03-17T05:17:58.0108663Z',
            },
            'amount' => 500,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'phoneverification' => {
                'token' => '8b340ecdfc63ccccccc1fe59310',
                'pin' => '6010'
            }
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

    phoneVerification = ApRubySdk::PhoneVerification.new(
        'token' => '8b340ecdfc63ccccccc1fe59310',
        'pin' => '6010'
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'phoneverification' => phoneVerification
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

  def test_retrieve_all_transactions
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/').
        with(

            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
        {

            'transactions' => [
                {
                    'id' => 'trn_d12209838b',
                    'mode' => 'Live',
                    'status' => 'Funded',
                    'customer' => {
                        'id' => 'cus_bd838e3611d34d598',
                        'mode' => 'Live',
                        'firstName' => 'John',
                        'lastName' => 'Doe',
                        'email' => 'john@doe.com',
                        'country' => 'US',
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'payment' => {
                        'id' => 'pay_ffd25121f84e4d249',
                        'mode' => 'Live',
                        'holder' => 'John Doe',
                        'paymentOption' => 'Giropay',
                        'bic' => 'TESTDETT421',
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'amount' => 300,
                    'currency' => 'EUR',
                    'created' => '2016-03-24T15:19:10.7800694Z',
                    'redirectUrls'=> {
                        'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
                    }
                },
                {
                    'id' => 'trn_d12209838c',
                    'mode' => 'Live',
                    'status' => 'Funded',
                    'customer' => {
                        'id' => 'cus_bd838e3611d34d598',
                        'mode' => 'Live',
                        'firstName' => 'John',
                        'lastName' => 'Doe',
                        'email' => 'john@doe.com',
                        'country' => 'US',
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'payment' => {
                        'id' => 'pay_ffd25121f84e4d249',
                        'mode' => 'Live',
                        'holder' => 'John Doe',
                        'paymentOption' => 'CreditCard',
                        'creditCardNumber' => 'XXXXXXXXXXX1111',
                        'creditCardType' => 'visa',
                        'expirationMonth' => 12,
                        'expirationYear' => 2019,
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'amount' => 1500,
                    'currency' => 'EUR',
                    'created' => '2016-03-24T15:19:10.7800694Z'
                }
            ]
        },
        :headers => {}))

    transactions = ApRubySdk::Transaction.all

    assert_equal(2, transactions.length)

    first_transaction = transactions[0]

    assert_equal('trn_d12209838b', first_transaction.id)
    assert_equal('Giropay', first_transaction.payment.paymentOption)
    assert_equal(300, first_transaction.amount)

    second_transaction = transactions[1]

    assert_equal('trn_d12209838c', second_transaction.id)
    assert_equal('CreditCard', second_transaction.payment.paymentOption)
    assert_equal(1500, second_transaction.amount)
  end

  def test_retrieve_transaction
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_d12209838b').
        with(
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
            'status' => 'Funded',
            'customer' => {
                'id' => 'cus_bd838e3611d34d598',
                'mode' => 'Live',
                'firstName' => 'John',
                'lastName' => 'Doe',
                'email' => 'john@doe.com',
                'country' => 'US',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'payment' => {
                'id' => 'pay_ffd25121f84e4d249',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'Giropay',
                'bic' => 'TESTDETT421',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'amount' => 300,
            'currency' => 'EUR',
            'created' => '2016-03-24T15:19:10.7800694Z',
            'redirectUrls'=> {
                'cancelUrl'=> 'http://plugins.alternativepayments.com/message/failure.html'
            }
        },
        :headers => {}))

    transaction = ApRubySdk::Transaction.retrieve('trn_d12209838b')

    assert_equal('trn_d12209838b', transaction.id)
    assert_equal('Live', transaction.mode)
    assert_equal('cus_bd838e3611d34d598', transaction.customer.id)
    assert_equal('Live', transaction.customer.mode)
    assert_equal('John', transaction.customer.firstName)
    assert_equal('Doe', transaction.customer.lastName)
    assert_equal('john@doe.com', transaction.customer.email)
    assert_equal('US', transaction.customer.country)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.customer.created)
    assert_equal('pay_ffd25121f84e4d249', transaction.payment.id)
    assert_equal('Live', transaction.payment.mode)
    assert_equal('John Doe', transaction.payment.holder)
    assert_equal('Giropay', transaction.payment.paymentOption)
    assert_equal('TESTDETT421', transaction.payment.bic)
    assert_equal(300, transaction.amount)
    assert_equal('EUR', transaction.currency)
  end

end