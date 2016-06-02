require 'test_helper'

class VoidTest < Minitest::Test

  def test_void_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids').
        with(
            body: hash_including(
                {
                    reason: ApRubySdk::RefundReason::FRAUD
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
                                          'id' => 'void_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => ApRubySdk::RefundReason::FRAUD,
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Voided',
                                              'amount' => 4000,
                                              'currency' => 'EUR',
                                              'created' => '2015-06-24T11:46:35.303Z'
                                          },
                                          'created' => '2015-06-24T11:47:30.6806641Z',
                                          'status' => 'Approved'
                                      },
                                      :headers => {}))

    void = ApRubySdk::Transaction.void(ApRubySdk::RefundReason::FRAUD, 'trn_41f1487')

    assert_equal(4000, void.amount)
    assert_equal('EUR', void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, void.reason)
    assert_equal('trn_41f1487', void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.6806641Z', void.created)
    assert_equal('Approved', void.status)

    assert_equal('trn_41f1487', void.originalTransaction.id)
    assert_equal('Voided', void.originalTransaction.status)
    assert_equal(4000, void.originalTransaction.amount)
    assert_equal('EUR', void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.created)
  end

  def test_void_transaction_on_instance
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids').
        with(
            body: hash_including(
                {
                    reason: ApRubySdk::RefundReason::FRAUD
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
                                          'id' => 'void_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => ApRubySdk::RefundReason::FRAUD,
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Voided',
                                              'amount' => 4000,
                                              'currency' => 'EUR',
                                              'created' => '2015-06-24T11:46:35.303Z'
                                          },
                                          'created' => '2015-06-24T11:47:30.6806641Z',
                                          'status' => 'Approved'
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

    transaction = ApRubySdk::Transaction.new(
        'id' => 'trn_41f1487',
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR'
    )

    void = transaction.void(ApRubySdk::RefundReason::FRAUD)

    assert_equal(4000, void.amount)
    assert_equal('EUR', void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, void.reason)
    assert_equal('trn_41f1487', void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.6806641Z', void.created)
    assert_equal('Approved', void.status)

    assert_equal('trn_41f1487', void.originalTransaction.id)
    assert_equal('Voided', void.originalTransaction.status)
    assert_equal(4000, void.originalTransaction.amount)
    assert_equal('EUR', void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.created)
  end

  def test_retrieve_void
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids/void_0a3f6b2').
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
                                          'id' => 'void_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => ApRubySdk::RefundReason::FRAUD,
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Voided',
                                              'customer' => {
                                                  'id' => 'cus_7f0724f3b1d745d49',
                                                  'mode' => 'Live',
                                                  'firstName' => 'Jane',
                                                  'lastName' => 'Doe',
                                                  'email' => 'jane@doe.com',
                                                  'country' => 'DE',
                                                  'created' => '2015-06-24T11:46:35.303Z'
                                              },
                                              'payment' => {
                                                  'id' => 'pay_13f3beaf091b43308',
                                                  'mode' => 'Live',
                                                  'customerId' => 'cus_7f0724f3b1d745d49',
                                                  'paymentOption' => 'SEPA',
                                                  'holder' => 'John Doe',
                                                  'created' => '2015-06-24T11:46:35.267Z'
                                              },
                                              'amount' => 4000,
                                              'currency' => 'EUR',
                                              'created' => '2015-06-24T11:46:35.303Z'
                                          },
                                          'created' => '2015-06-24T11:47:30.68Z',
                                          'status' => 'Approved'
                                      },
                                      :headers => {}))

    void = ApRubySdk::Transaction.retrieve_void('void_0a3f6b2', 'trn_41f1487')

    assert_equal('void_0a3f6b2', void.id)
    assert_equal(4000, void.amount)
    assert_equal('EUR', void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, void.reason)
    assert_equal('trn_41f1487', void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', void.created)
    assert_equal('Approved', void.status)

    assert_equal('trn_41f1487', void.originalTransaction.id)
    assert_equal('Voided', void.originalTransaction.status)
    assert_equal(4000, void.originalTransaction.amount)
    assert_equal('EUR', void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', void.originalTransaction.customer.id)
    assert_equal('Jane', void.originalTransaction.customer.firstName)
    assert_equal('Doe', void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', void.originalTransaction.customer.email)
    assert_equal('DE', void.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.customer.created)

  end

  def test_retrieve_void_on_instance
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids/void_0a3f6b2').
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
                                          'id' => 'void_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => ApRubySdk::RefundReason::FRAUD,
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Voided',
                                              'customer' => {
                                                  'id' => 'cus_7f0724f3b1d745d49',
                                                  'mode' => 'Live',
                                                  'firstName' => 'Jane',
                                                  'lastName' => 'Doe',
                                                  'email' => 'jane@doe.com',
                                                  'country' => 'DE',
                                                  'created' => '2015-06-24T11:46:35.303Z'
                                              },
                                              'payment' => {
                                                  'id' => 'pay_13f3beaf091b43308',
                                                  'mode' => 'Live',
                                                  'customerId' => 'cus_7f0724f3b1d745d49',
                                                  'paymentOption' => 'SEPA',
                                                  'holder' => 'John Doe',
                                                  'created' => '2015-06-24T11:46:35.267Z'
                                              },
                                              'amount' => 4000,
                                              'currency' => 'EUR',
                                              'created' => '2015-06-24T11:46:35.303Z'
                                          },
                                          'created' => '2015-06-24T11:47:30.68Z',
                                          'status' => 'Approved'
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_7f0724f3b1d745d49',
        'mode' => 'Live',
        'firstName' => 'Jane',
        'lastName' => 'Doe',
        'email' => 'jane@doe.com',
        'country' => 'DE',
        'created' => '2015-06-24T11:46:35.303Z'
    )

    payment = ApRubySdk::Payment.new(
        'id' => 'pay_13f3beaf091b43308',
        'mode' => 'Live',
        'customerId' => 'cus_7f0724f3b1d745d49',
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'created' => '2015-06-24T11:46:35.267Z'
    )

    transaction = ApRubySdk::Transaction.new(
        'id' => 'trn_41f1487',
        'customer' => customer,
        'payment' => payment,
        'amount' => 4000,
        'currency' => 'EUR'
    )

    void = transaction.retrieve_void('void_0a3f6b2')

    assert_equal('void_0a3f6b2', void.id)
    assert_equal(4000, void.amount)
    assert_equal('EUR', void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, void.reason)
    assert_equal('trn_41f1487', void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', void.created)
    assert_equal('Approved', void.status)

    assert_equal('trn_41f1487', void.originalTransaction.id)
    assert_equal('Voided', void.originalTransaction.status)
    assert_equal(4000, void.originalTransaction.amount)
    assert_equal('EUR', void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', void.originalTransaction.customer.id)
    assert_equal('Jane', void.originalTransaction.customer.firstName)
    assert_equal('Doe', void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', void.originalTransaction.customer.email)
    assert_equal('DE', void.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', void.originalTransaction.customer.created)
  end

  def test_retrieve_all_voids
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids/').
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
                                          'voidTransactions' => [
                                              {
                                                  'id' => 'void_0a3f6b2',
                                                  'mode' => 'Live',
                                                  'amount' => 4000,
                                                  'currency' => 'EUR',
                                                  'reason' => ApRubySdk::RefundReason::FRAUD,
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Voided',
                                                      'customer' => {
                                                          'id' => 'cus_7f0724f3b1d745d49',
                                                          'mode' => 'Live',
                                                          'firstName' => 'Jane',
                                                          'lastName' => 'Doe',
                                                          'email' => 'jane@doe.com',
                                                          'country' => 'DE',
                                                          'created' => '2015-06-24T11:46:35.303Z'
                                                      },
                                                      'payment' => {
                                                          'id' => 'pay_13f3beaf091b43308',
                                                          'mode' => 'Live',
                                                          'customerId' => 'cus_7f0724f3b1d745d49',
                                                          'paymentOption' => 'SEPA',
                                                          'holder' => 'Johny Smithy',
                                                          'created' => '2015-06-24T11:46:35.267Z'
                                                      },
                                                      'amount' => 8000,
                                                      'currency' => 'EUR',
                                                      'created' => '2015-06-24T11:46:35.303Z'
                                                  },
                                                  'created' => '2015-06-24T11:47:30.68Z',
                                                  'status' => 'Approved'
                                              },
                                              {
                                                  'id' => 'void_0a332b2',
                                                  'mode' => 'Live',
                                                  'amount' => 250,
                                                  'currency' => 'EUR',
                                                  'reason' => ApRubySdk::RefundReason::FRAUD,
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Voided',
                                                      'customer' => {
                                                          'id' => 'cus_7f0724f3b1d745d49',
                                                          'mode' => 'Live',
                                                          'firstName' => 'Jane',
                                                          'lastName' => 'Doe',
                                                          'email' => 'jane@doe.com',
                                                          'country' => 'DE',
                                                          'created' => '2015-06-27T11:46:35.303Z'
                                                      },
                                                      'payment' => {
                                                          'id' => 'pay_13f3beaf091b43308',
                                                          'mode' => 'Live',
                                                          'customerId' => 'cus_7f0724f3b1d745d49',
                                                          'paymentOption' => 'SEPA',
                                                          'holder' => 'Johny Smithy',
                                                          'created' => '2015-06-24T11:46:35.267Z'
                                                      },
                                                      'amount' => 8000,
                                                      'currency' => 'EUR',
                                                      'created' => '2015-06-24T11:46:35.303Z'
                                                  },
                                                  'created' => '2015-06-24T11:47:30.68Z',
                                                  'status' => 'Approved'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    voids = ApRubySdk::Transaction.voids('trn_41f1487')

    assert_equal(2, voids.length)

    first_void = voids[0]
    assert_equal('void_0a3f6b2', first_void.id)
    assert_equal(4000, first_void.amount)
    assert_equal('EUR', first_void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, first_void.reason)
    assert_equal('trn_41f1487', first_void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', first_void.created)
    assert_equal('Approved', first_void.status)

    assert_equal('trn_41f1487', first_void.originalTransaction.id)
    assert_equal('Voided', first_void.originalTransaction.status)
    assert_equal(8000, first_void.originalTransaction.amount)
    assert_equal('EUR', first_void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', first_void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', first_void.originalTransaction.customer.id)
    assert_equal('Jane', first_void.originalTransaction.customer.firstName)
    assert_equal('Doe', first_void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', first_void.originalTransaction.customer.email)
    assert_equal('DE', first_void.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', first_void.originalTransaction.customer.created)

    second_void = voids[1]
    assert_equal('void_0a332b2', second_void.id)
    assert_equal(250, second_void.amount)
    assert_equal('EUR', second_void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, second_void.reason)
    assert_equal('trn_41f1487', second_void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', second_void.created)
    assert_equal('Approved', second_void.status)

    assert_equal('trn_41f1487', second_void.originalTransaction.id)
    assert_equal('Voided', second_void.originalTransaction.status)
    assert_equal(8000, second_void.originalTransaction.amount)
    assert_equal('EUR', second_void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', second_void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', second_void.originalTransaction.customer.id)
    assert_equal('Jane', second_void.originalTransaction.customer.firstName)
    assert_equal('Doe', second_void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', second_void.originalTransaction.customer.email)
    assert_equal('DE', second_void.originalTransaction.customer.country)
    assert_equal('2015-06-27T11:46:35.303Z', second_void.originalTransaction.customer.created)
  end

  def test_retrieve_all_voids_on_instance
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/voids/').
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
                                          'voidTransactions' => [
                                              {
                                                  'id' => 'void_0a3f6b2',
                                                  'mode' => 'Live',
                                                  'amount' => 4000,
                                                  'currency' => 'EUR',
                                                  'reason' => ApRubySdk::RefundReason::FRAUD,
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Voided',
                                                      'customer' => {
                                                          'id' => 'cus_7f0724f3b1d745d49',
                                                          'mode' => 'Live',
                                                          'firstName' => 'Jane',
                                                          'lastName' => 'Doe',
                                                          'email' => 'jane@doe.com',
                                                          'country' => 'DE',
                                                          'created' => '2015-06-24T11:46:35.303Z'
                                                      },
                                                      'payment' => {
                                                          'id' => 'pay_13f3beaf091b43308',
                                                          'mode' => 'Live',
                                                          'customerId' => 'cus_7f0724f3b1d745d49',
                                                          'paymentOption' => 'SEPA',
                                                          'holder' => 'Johny Smithy',
                                                          'created' => '2015-06-24T11:46:35.267Z'
                                                      },
                                                      'amount' => 8000,
                                                      'currency' => 'EUR',
                                                      'created' => '2015-06-24T11:46:35.303Z'
                                                  },
                                                  'created' => '2015-06-24T11:47:30.68Z',
                                                  'status' => 'Approved'
                                              },
                                              {
                                                  'id' => 'void_0a332b2',
                                                  'mode' => 'Live',
                                                  'amount' => 250,
                                                  'currency' => 'EUR',
                                                  'reason' => ApRubySdk::RefundReason::FRAUD,
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Voided',
                                                      'customer' => {
                                                          'id' => 'cus_7f0724f3b1d745d49',
                                                          'mode' => 'Live',
                                                          'firstName' => 'Jane',
                                                          'lastName' => 'Doe',
                                                          'email' => 'jane@doe.com',
                                                          'country' => 'DE',
                                                          'created' => '2015-06-27T11:46:35.303Z'
                                                      },
                                                      'payment' => {
                                                          'id' => 'pay_13f3beaf091b43308',
                                                          'mode' => 'Live',
                                                          'customerId' => 'cus_7f0724f3b1d745d49',
                                                          'paymentOption' => 'SEPA',
                                                          'holder' => 'Johny Smithy',
                                                          'created' => '2015-06-24T11:46:35.267Z'
                                                      },
                                                      'amount' => 8000,
                                                      'currency' => 'EUR',
                                                      'created' => '2015-06-24T11:46:35.303Z'
                                                  },
                                                  'created' => '2015-06-24T11:47:30.68Z',
                                                  'status' => 'Approved'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_7f0724f3b1d745d49',
        'mode' => 'Live',
        'firstName' => 'Jane',
        'lastName' => 'Doe',
        'email' => 'jane@doe.com',
        'country' => 'DE',
        'created' => '2015-06-24T11:46:35.303Z'
    )

    payment = ApRubySdk::Payment.new(
        'id' => 'pay_13f3beaf091b43308',
        'mode' => 'Live',
        'customerId' => 'cus_7f0724f3b1d745d49',
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'created' => '2015-06-24T11:46:35.267Z'
    )

    transaction = ApRubySdk::Transaction.new(
        'id' => 'trn_41f1487',
        'customer' => customer,
        'payment' => payment,
        'amount' => 8000,
        'currency' => 'EUR'
    )

    voids = transaction.voids('trn_41f1487')

    assert_equal(2, voids.length)

    first_void = voids[0]
    assert_equal('void_0a3f6b2', first_void.id)
    assert_equal(4000, first_void.amount)
    assert_equal('EUR', first_void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, first_void.reason)
    assert_equal('trn_41f1487', first_void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', first_void.created)
    assert_equal('Approved', first_void.status)

    assert_equal('trn_41f1487', first_void.originalTransaction.id)
    assert_equal('Voided', first_void.originalTransaction.status)
    assert_equal(8000, first_void.originalTransaction.amount)
    assert_equal('EUR', first_void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', first_void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', first_void.originalTransaction.customer.id)
    assert_equal('Jane', first_void.originalTransaction.customer.firstName)
    assert_equal('Doe', first_void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', first_void.originalTransaction.customer.email)
    assert_equal('DE', first_void.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', first_void.originalTransaction.customer.created)

    second_void = voids[1]
    assert_equal('void_0a332b2', second_void.id)
    assert_equal(250, second_void.amount)
    assert_equal('EUR', second_void.currency)
    assert_equal(ApRubySdk::RefundReason::FRAUD, second_void.reason)
    assert_equal('trn_41f1487', second_void.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', second_void.created)
    assert_equal('Approved', second_void.status)

    assert_equal('trn_41f1487', second_void.originalTransaction.id)
    assert_equal('Voided', second_void.originalTransaction.status)
    assert_equal(8000, second_void.originalTransaction.amount)
    assert_equal('EUR', second_void.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', second_void.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', second_void.originalTransaction.customer.id)
    assert_equal('Jane', second_void.originalTransaction.customer.firstName)
    assert_equal('Doe', second_void.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', second_void.originalTransaction.customer.email)
    assert_equal('DE', second_void.originalTransaction.customer.country)
    assert_equal('2015-06-27T11:46:35.303Z', second_void.originalTransaction.customer.created)
  end
end