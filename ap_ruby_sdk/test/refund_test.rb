require 'test_helper'

class RefundTest < Minitest::Test

  def test_refund_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds').
        with(
            body: hash_including(
                {
                    reason: 'FRAUD'
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
                                          'id' => 'ref_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => 'FRAUD',
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Refunded',
                                              'amount' => 4000,
                                              'currency' => 'EUR',
                                              'created' => '2015-06-24T11:46:35.303Z'
                                          },
                                          'created' => '2015-06-24T11:47:30.6806641Z',
                                          'status' => 'Approved'
                                      },
                                      :headers => {}))

    refund = ApRubySdk::Transaction.refund('FRAUD', 'trn_41f1487')

    assert_equal('ref_0a3f6b2', refund.id)
    assert_equal(4000, refund.amount)
    assert_equal('EUR', refund.currency)
    assert_equal('FRAUD', refund.reason)
    assert_equal('trn_41f1487', refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.6806641Z', refund.created)
    assert_equal('Approved', refund.status)

    assert_equal('trn_41f1487', refund.originalTransaction.id)
    assert_equal('Refunded', refund.originalTransaction.status)
    assert_equal(4000, refund.originalTransaction.amount)
    assert_equal('EUR', refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.created)
  end

  def test_refund_transaction_on_instance
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds').
        with(
            body: hash_including(
                {
                    reason: 'FRAUD'
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
                                          'id' => 'ref_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => 'FRAUD',
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Refunded',
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

    refund = transaction.refund('FRAUD')

    assert_equal('ref_0a3f6b2', refund.id)
    assert_equal(4000, refund.amount)
    assert_equal('EUR', refund.currency)
    assert_equal('FRAUD', refund.reason)
    assert_equal('trn_41f1487', refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.6806641Z', refund.created)
    assert_equal('Approved', refund.status)

    assert_equal('trn_41f1487', refund.originalTransaction.id)
    assert_equal('Refunded', refund.originalTransaction.status)
    assert_equal(4000, refund.originalTransaction.amount)
    assert_equal('EUR', refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.created)
  end

  def test_retrieve_refund
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds/ref_0a3f6b2').
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
                                          'id' => 'ref_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => 'FRAUD',
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Refunded',
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

    refund = ApRubySdk::Transaction.retrieve_refund('ref_0a3f6b2', 'trn_41f1487')

    assert_equal('ref_0a3f6b2', refund.id)
    assert_equal(4000, refund.amount)
    assert_equal('EUR', refund.currency)
    assert_equal('FRAUD', refund.reason)
    assert_equal('trn_41f1487', refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', refund.created)
    assert_equal('Approved', refund.status)

    assert_equal('trn_41f1487', refund.originalTransaction.id)
    assert_equal('Refunded', refund.originalTransaction.status)
    assert_equal(4000, refund.originalTransaction.amount)
    assert_equal('EUR', refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', refund.originalTransaction.customer.id)
    assert_equal('Jane', refund.originalTransaction.customer.firstName)
    assert_equal('Doe', refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', refund.originalTransaction.customer.email)
    assert_equal('DE', refund.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.customer.created)

  end

  def test_retrieve_refund_on_instance
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds/ref_0a3f6b2').
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
                                          'id' => 'ref_0a3f6b2',
                                          'mode' => 'Live',
                                          'amount' => 4000,
                                          'currency' => 'EUR',
                                          'reason' => 'FRAUD',
                                          'originalTransactionId' => 'trn_41f1487',
                                          'originalTransaction' => {
                                              'id' => 'trn_41f1487',
                                              'mode' => 'Live',
                                              'status' => 'Refunded',
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

    refund = transaction.retrieve_refund('ref_0a3f6b2')

    assert_equal('ref_0a3f6b2', refund.id)
    assert_equal(4000, refund.amount)
    assert_equal('EUR', refund.currency)
    assert_equal('FRAUD', refund.reason)
    assert_equal('trn_41f1487', refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', refund.created)
    assert_equal('Approved', refund.status)

    assert_equal('trn_41f1487', refund.originalTransaction.id)
    assert_equal('Refunded', refund.originalTransaction.status)
    assert_equal(4000, refund.originalTransaction.amount)
    assert_equal('EUR', refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', refund.originalTransaction.customer.id)
    assert_equal('Jane', refund.originalTransaction.customer.firstName)
    assert_equal('Doe', refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', refund.originalTransaction.customer.email)
    assert_equal('DE', refund.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', refund.originalTransaction.customer.created)
  end

  def test_retrieve_all_refunds
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds/').
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
                                          'refundTransactions' => [
                                              {
                                                  'id' => 'ref_0a3f6b2',
                                                  'mode' => 'Live',
                                                  'amount' => 4000,
                                                  'currency' => 'EUR',
                                                  'reason' => 'Fraud',
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Refunded',
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
                                                  'id' => 'ref_0a332b2',
                                                  'mode' => 'Live',
                                                  'amount' => 250,
                                                  'currency' => 'EUR',
                                                  'reason' => 'Fraud',
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Refunded',
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

    refunds = ApRubySdk::Transaction.refunds('trn_41f1487')

    assert_equal(2, refunds.length)

    first_refund = refunds[0]
    assert_equal('ref_0a3f6b2', first_refund.id)
    assert_equal(4000, first_refund.amount)
    assert_equal('EUR', first_refund.currency)
    assert_equal('Fraud', first_refund.reason)
    assert_equal('trn_41f1487', first_refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', first_refund.created)
    assert_equal('Approved', first_refund.status)

    assert_equal('trn_41f1487', first_refund.originalTransaction.id)
    assert_equal('Refunded', first_refund.originalTransaction.status)
    assert_equal(8000, first_refund.originalTransaction.amount)
    assert_equal('EUR', first_refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', first_refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', first_refund.originalTransaction.customer.id)
    assert_equal('Jane', first_refund.originalTransaction.customer.firstName)
    assert_equal('Doe', first_refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', first_refund.originalTransaction.customer.email)
    assert_equal('DE', first_refund.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', first_refund.originalTransaction.customer.created)

    second_refund = refunds[1]
    assert_equal('ref_0a332b2', second_refund.id)
    assert_equal(250, second_refund.amount)
    assert_equal('EUR', second_refund.currency)
    assert_equal('Fraud', second_refund.reason)
    assert_equal('trn_41f1487', second_refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', second_refund.created)
    assert_equal('Approved', second_refund.status)

    assert_equal('trn_41f1487', second_refund.originalTransaction.id)
    assert_equal('Refunded', second_refund.originalTransaction.status)
    assert_equal(8000, second_refund.originalTransaction.amount)
    assert_equal('EUR', second_refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', second_refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', second_refund.originalTransaction.customer.id)
    assert_equal('Jane', second_refund.originalTransaction.customer.firstName)
    assert_equal('Doe', second_refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', second_refund.originalTransaction.customer.email)
    assert_equal('DE', second_refund.originalTransaction.customer.country)
    assert_equal('2015-06-27T11:46:35.303Z', second_refund.originalTransaction.customer.created)
  end

  def test_retrieve_all_refunds_on_instance
    stub_request(:get, 'https://api.alternativepayments.com/api/transactions/trn_41f1487/refunds/').
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
                                          'refundTransactions' => [
                                              {
                                                  'id' => 'ref_0a3f6b2',
                                                  'mode' => 'Live',
                                                  'amount' => 4000,
                                                  'currency' => 'EUR',
                                                  'reason' => 'Fraud',
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Refunded',
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
                                                  'id' => 'ref_0a332b2',
                                                  'mode' => 'Live',
                                                  'amount' => 250,
                                                  'currency' => 'EUR',
                                                  'reason' => 'Fraud',
                                                  'originalTransactionId' => 'trn_41f1487',
                                                  'originalTransaction' => {
                                                      'id' => 'trn_41f1487',
                                                      'mode' => 'Live',
                                                      'status' => 'Refunded',
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

    refunds = transaction.refunds('trn_41f1487')

    assert_equal(2, refunds.length)

    first_refund = refunds[0]
    assert_equal('ref_0a3f6b2', first_refund.id)
    assert_equal(4000, first_refund.amount)
    assert_equal('EUR', first_refund.currency)
    assert_equal('Fraud', first_refund.reason)
    assert_equal('trn_41f1487', first_refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', first_refund.created)
    assert_equal('Approved', first_refund.status)

    assert_equal('trn_41f1487', first_refund.originalTransaction.id)
    assert_equal('Refunded', first_refund.originalTransaction.status)
    assert_equal(8000, first_refund.originalTransaction.amount)
    assert_equal('EUR', first_refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', first_refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', first_refund.originalTransaction.customer.id)
    assert_equal('Jane', first_refund.originalTransaction.customer.firstName)
    assert_equal('Doe', first_refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', first_refund.originalTransaction.customer.email)
    assert_equal('DE', first_refund.originalTransaction.customer.country)
    assert_equal('2015-06-24T11:46:35.303Z', first_refund.originalTransaction.customer.created)

    second_refund = refunds[1]
    assert_equal('ref_0a332b2', second_refund.id)
    assert_equal(250, second_refund.amount)
    assert_equal('EUR', second_refund.currency)
    assert_equal('Fraud', second_refund.reason)
    assert_equal('trn_41f1487', second_refund.originalTransactionId)
    assert_equal('2015-06-24T11:47:30.68Z', second_refund.created)
    assert_equal('Approved', second_refund.status)

    assert_equal('trn_41f1487', second_refund.originalTransaction.id)
    assert_equal('Refunded', second_refund.originalTransaction.status)
    assert_equal(8000, second_refund.originalTransaction.amount)
    assert_equal('EUR', second_refund.originalTransaction.currency)
    assert_equal('2015-06-24T11:46:35.303Z', second_refund.originalTransaction.created)

    assert_equal('cus_7f0724f3b1d745d49', second_refund.originalTransaction.customer.id)
    assert_equal('Jane', second_refund.originalTransaction.customer.firstName)
    assert_equal('Doe', second_refund.originalTransaction.customer.lastName)
    assert_equal('jane@doe.com', second_refund.originalTransaction.customer.email)
    assert_equal('DE', second_refund.originalTransaction.customer.country)
    assert_equal('2015-06-27T11:46:35.303Z', second_refund.originalTransaction.customer.created)
  end
end