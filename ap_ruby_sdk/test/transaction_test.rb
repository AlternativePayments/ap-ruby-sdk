require 'test_helper'

class TransactionTest < Minitest::Test

  def test_create_sepa_transaction
    stub_request(:post, 'https://api.alternativepayments.com/api/transactions').
        with(
            body: '{'\
                    '"id":"trn_d12209838b",'\
                    '"mode":"Live",'\
                    '"customer":{'\
                      '"id":"cus_bd838e3611d34d598",'\
                      '"mode":"Live",'\
                      '"firstName":"John",'\
                      '"lastName":"Doe",'\
                      '"email":"john@doe.com",'\
                      '"country":"DE",'\
                      '"created":"2016-03-24T15:19:10.7800694Z"'\
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
                                          'amount' => 500,
                                          'currency' => 'EUR',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'mode' => 'Live',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE',
        'created' => '2016-03-24T15:19:10.7800694Z'
    )

    transaction = ApRubySdk::Transaction.create(
        'id' => 'trn_d12209838b',
        'mode' => 'Live',
        'customer' => customer,
        'amount' => 500,
        'currency' => 'EUR'
    )

    assert_equal('trn_d12209838b', transaction.id)
    assert_equal('Live', transaction.mode)
    assert_equal(500, transaction.amount)
    assert_equal('EUR', transaction.currency)
    assert_equal('2016-03-24T15:19:10.7800694Z', transaction.created)
  end

end