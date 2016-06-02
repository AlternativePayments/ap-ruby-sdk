require 'test_helper'

class SubscriptionTest < Minitest::Test

  def test_create_subscription
    stub_request(:post, 'https://api.alternativepayments.com/api/subscriptions').
        with(
            body: hash_including(
                {
                    paymentId: 'pay_a7cc4479772c4cdc8',
                    customerId: 'cus_70ac08b06b4949bfb',
                    planId: 'pln_a27286a'
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
                                          'id' => 'sbs_d12209838b',
                                          'mode' => 'Live',
                                          'planId' => 'pln_a27286a',
                                          'plan' => {
                                              'id' => 'pln_a27286a',
                                              'mode' => 'Test',
                                              'name' => 'Test',
                                              'description' => 'Test plan',
                                              'amount' => 1000,
                                              'currency' => 'EUR',
                                              'period' => 'Day',
                                              'interval' => 5,
                                              'created' => '2016-03-24T15:19:10.7800694Z'
                                          },
                                          'customerId' => 'cus_70ac08b06b4949bfb',
                                          'customer' => {
                                              'id' => 'cus_70ac08b06b4949bfb',
                                              'mode' => 'Live',
                                              'firstName' => 'John',
                                              'lastName' => 'Doe',
                                              'email' => 'john@doe.com',
                                              'country' => 'DE',
                                              'created' => '2016-03-24T15:19:10.7800694Z'
                                          },
                                          'paymentId' => 'pay_a7cc4479772c4cdc8',
                                          'payment' => {
                                              'id' => 'pay_a7cc4479772c4cdc8',
                                              'mode' => 'Live',
                                              'holder' => 'John Doe',
                                              'paymentOption' => 'SEPA',
                                              'iban' => 'DE71XXXXX3330'
                                          },
                                          'status' => 'InRecur',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    subscription = ApRubySdk::Subscription.create(
        'customerId' => 'cus_70ac08b06b4949bfb',
        'paymentId' => 'pay_a7cc4479772c4cdc8',
        'planId' => 'pln_a27286a'
    )

    assert_equal('sbs_d12209838b', subscription.id)
    assert_equal('Live', subscription.mode)
    assert_equal('cus_70ac08b06b4949bfb', subscription.customer.id)
    assert_equal('cus_70ac08b06b4949bfb', subscription.customerId)
    assert_equal('pay_a7cc4479772c4cdc8', subscription.payment.id)
    assert_equal('pay_a7cc4479772c4cdc8', subscription.paymentId)
    assert_equal('pln_a27286a', subscription.plan.id)
    assert_equal('pln_a27286a', subscription.planId)
    assert_equal('InRecur', subscription.status)
    assert_equal('2016-03-24T15:19:10.7800694Z', subscription.created)
  end

  def test_retrieve_all_subscription
    stub_request(:get, 'https://api.alternativepayments.com/api/subscriptions/').
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

            'subscriptions' => [
                {
                    'id' => 'sbs_d12209838b',
                    'mode' => 'Live',
                    'planId' => 'pln_a27286a',
                    'plan' => {
                        'id' => 'pln_a27286a',
                        'mode' => 'Test',
                        'name' => 'Test',
                        'description' => 'Test plan',
                        'amount' => 1000,
                        'currency' => 'EUR',
                        'period' => 'Day',
                        'interval' => 5,
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'customerId' => 'cus_70ac08b06b4949bfb',
                    'customer' => {
                        'id' => 'cus_70ac08b06b4949bfb',
                        'mode' => 'Live',
                        'firstName' => 'John',
                        'lastName' => 'Doe',
                        'email' => 'john@doe.com',
                        'country' => 'DE',
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'paymentId' => 'pay_a7cc4479772c4cdc8',
                    'payment' => {
                        'id' => 'pay_a7cc4479772c4cdc8',
                        'mode' => 'Live',
                        'holder' => 'John Doe',
                        'paymentOption' => 'SEPA',
                        'iban' => 'DE71XXXXX3330'
                    },
                    'status' => 'InRecur',
                    'created' => '2016-03-24T15:19:10.7800694Z'
                },
                {
                    'id' => 'sbs_d12209838c',
                    'mode' => 'Live',
                    'planId' => 'pln_a27286c',
                    'plan' => {
                        'id' => 'pln_a27286c',
                        'mode' => 'Test',
                        'name' => 'Test',
                        'description' => 'Test plan',
                        'amount' => 1000,
                        'currency' => 'EUR',
                        'period' => 'Day',
                        'interval' => 5,
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'customerId' => 'cus_70ac08b06b4949bfc',
                    'customer' => {
                        'id' => 'cus_70ac08b06b4949bfc',
                        'mode' => 'Live',
                        'firstName' => 'John',
                        'lastName' => 'Doe',
                        'email' => 'john@doe.com',
                        'country' => 'DE',
                        'created' => '2016-03-24T15:19:10.7800694Z'
                    },
                    'paymentId' => 'pay_a7cc4479772c4cdcc',
                    'payment' => {
                        'id' => 'pay_a7cc4479772c4cdcc',
                        'mode' => 'Live',
                        'holder' => 'John Doe',
                        'paymentOption' => 'SEPA',
                        'iban' => 'DE71XXXXX3330'
                    },
                    'status' => 'InRecur',
                    'created' => '2016-03-24T15:19:10.7800694Z'
                }
            ]
        },
        :headers => {}))

    subscriptions = ApRubySdk::Subscription.all

    assert_equal(2, subscriptions.length)

    first_subscription = subscriptions[0]

    assert_equal('cus_70ac08b06b4949bfb', first_subscription.customerId)
    assert_equal('pay_a7cc4479772c4cdc8', first_subscription.paymentId)
    assert_equal('pln_a27286a', first_subscription.planId)

    second_subscription = subscriptions[1]

    assert_equal('cus_70ac08b06b4949bfc', second_subscription.customerId)
    assert_equal('pay_a7cc4479772c4cdcc', second_subscription.paymentId)
    assert_equal('pln_a27286c', second_subscription.planId)
  end

  def test_retrieve_subscription
    stub_request(:get, 'https://api.alternativepayments.com/api/subscriptions/sbs_d12209838b').
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
            'id' => 'sbs_d12209838b',
            'mode' => 'Live',
            'planId' => 'pln_a27286a',
            'plan' => {
                'id' => 'pln_a27286a',
                'mode' => 'Test',
                'name' => 'Test',
                'description' => 'Test plan',
                'amount' => 1000,
                'currency' => 'EUR',
                'period' => 'Day',
                'interval' => 5,
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'customerId' => 'cus_70ac08b06b4949bfb',
            'customer' => {
                'id' => 'cus_70ac08b06b4949bfb',
                'mode' => 'Live',
                'firstName' => 'John',
                'lastName' => 'Doe',
                'email' => 'john@doe.com',
                'country' => 'DE',
                'created' => '2016-03-24T15:19:10.7800694Z'
            },
            'paymentId' => 'pay_a7cc4479772c4cdc8',
            'payment' => {
                'id' => 'pay_a7cc4479772c4cdc8',
                'mode' => 'Live',
                'holder' => 'John Doe',
                'paymentOption' => 'SEPA',
                'iban' => 'DE71XXXXX3330'
            },
            'status' => 'InRecur',
            'created' => '2016-03-24T15:19:10.7800694Z'
        },
        :headers => {}))

    subscription = ApRubySdk::Subscription.retrieve('sbs_d12209838b')

    assert_equal('sbs_d12209838b', subscription.id)
    assert_equal('Live', subscription.mode)
    assert_equal('cus_70ac08b06b4949bfb', subscription.customer.id)
    assert_equal('cus_70ac08b06b4949bfb', subscription.customerId)
    assert_equal('pay_a7cc4479772c4cdc8', subscription.payment.id)
    assert_equal('pay_a7cc4479772c4cdc8', subscription.paymentId)
    assert_equal('pln_a27286a', subscription.plan.id)
    assert_equal('pln_a27286a', subscription.planId)
    assert_equal('InRecur', subscription.status)
    assert_equal('2016-03-24T15:19:10.7800694Z', subscription.created)
  end

end