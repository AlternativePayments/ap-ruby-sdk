require 'test_helper'

class CustomerTest < Minitest::Test

  def test_create_customer
    stub_request(:post, 'https://api.alternativepayments.com/api/customers').
        with(
            body: '{'\
                    '"id":"cus_bd838e3611d34d598",'\
                    '"mode":"Live",'\
                    '"firstName":"John",'\
                    '"lastName":"Doe",'\
                    '"email":"john@doe.com",'\
                    '"address":"Rutledge Ave 409",'\
                    '"city":"Folsom",'\
                    '"zip":"19033",'\
                    '"country":"US",'\
                    '"state":"PA",'\
                    '"phone":"55555555555",'\
                    '"created":"2016-03-24T15:19:10.7800694Z"'\
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
                                          'id' => 'cus_bd838e3611d34d598',
                                          'mode' => 'Live',
                                          'firstName' => 'John',
                                          'lastName' => 'Doe',
                                          'email' => 'john@doe.com',
                                          'address' => 'Rutledge Ave 409',
                                          'city' => 'Folsom',
                                          'zip' => '19033',
                                          'country' => 'US',
                                          'state' => 'PA',
                                          'phone' => '55555555555',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.create(
        'id' => 'cus_bd838e3611d34d598',
        'mode' => 'Live',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'address' => 'Rutledge Ave 409',
        'city' => 'Folsom',
        'zip' => '19033',
        'country' => 'US',
        'state' => 'PA',
        'phone' => '55555555555',
        'created' => '2016-03-24T15:19:10.7800694Z'
    )

    assert_equal('cus_bd838e3611d34d598', customer.id)
    assert_equal('Live', customer.mode)
    assert_equal('John', customer.firstName)
    assert_equal('Doe', customer.lastName)
    assert_equal('john@doe.com', customer.email)
    assert_equal('Rutledge Ave 409', customer.address)
    assert_equal('Folsom', customer.city)
    assert_equal('19033', customer.zip)
    assert_equal('US', customer.country)
    assert_equal('PA', customer.state)
    assert_equal('55555555555', customer.phone)
    assert_equal('2016-03-24T15:19:10.7800694Z', customer.created)
  end

  def test_retrieve_all_customers
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/').
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

                                          'customers' => [
                                              {
                                                  'id' => 'cus_7f0724f3b1d745d49',
                                                  'mode' => 'Live',
                                                  'firstName' => 'Jane',
                                                  'lastName' => 'Doe',
                                                  'email' => 'jane@doe.com',
                                                  'country' => 'DE',
                                                  'created' => '2015-06-24T11:46:35.303Z'
                                              },
                                              {
                                                  'id' => 'cus_15b154da474247dbb',
                                                  'mode' => 'Live',
                                                  'firstName' => 'John',
                                                  'lastName' => 'Doe',
                                                  'email' => 'john@doe.com',
                                                  'address' => 'Rutledge Ave 409',
                                                  'city' => 'Folsom',
                                                  'zip' => '19033',
                                                  'country' => 'US',
                                                  'phone' => '55555555555',
                                                  'created' => '2015-06-24T12:28:06.527Z'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    customers = ApRubySdk::Customer.all

    assert_equal(2, customers.length)

    first_customer = customers[0]

    assert_equal('cus_7f0724f3b1d745d49', first_customer.id)
    assert_equal('Live', first_customer.mode)
    assert_equal('Jane', first_customer.firstName)
    assert_equal('Doe', first_customer.lastName)
    assert_equal('jane@doe.com', first_customer.email)
    assert_nil(first_customer.address)
    assert_nil(first_customer.city)
    assert_nil(first_customer.zip)
    assert_equal('DE', first_customer.country)
    assert_nil(first_customer.state)
    assert_nil(first_customer.phone)
    assert_equal('2015-06-24T11:46:35.303Z', first_customer.created)

    second_customer = customers[1]

    assert_equal('cus_15b154da474247dbb', second_customer.id)
    assert_equal('Live', second_customer.mode)
    assert_equal('John', second_customer.firstName)
    assert_equal('Doe', second_customer.lastName)
    assert_equal('john@doe.com', second_customer.email)
    assert_equal('Rutledge Ave 409', second_customer.address)
    assert_equal('Folsom', second_customer.city)
    assert_equal('19033', second_customer.zip)
    assert_equal('US', second_customer.country)
    assert_nil(second_customer.state)
    assert_equal('55555555555', second_customer.phone)
    assert_equal('2015-06-24T12:28:06.527Z', second_customer.created)
  end

  def test_retrieve_customer
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/123').
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
                                          'id' => 'cus_bd838e3611d34d598',
                                          'mode' => 'Live',
                                          'firstName' => 'John',
                                          'lastName' => 'Doe',
                                          'email' => 'john@doe.com',
                                          'address' => 'Rutledge Ave 409',
                                          'city' => 'Folsom',
                                          'zip' => '19033',
                                          'country' => 'US',
                                          'state' => 'PA',
                                          'phone' => '55555555555',
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    customer = ApRubySdk::Customer.retrieve('123')

    assert_equal('cus_bd838e3611d34d598', customer.id)
    assert_equal('Live', customer.mode)
    assert_equal('John', customer.firstName)
    assert_equal('Doe', customer.lastName)
    assert_equal('john@doe.com', customer.email)
    assert_equal('Rutledge Ave 409', customer.address)
    assert_equal('Folsom', customer.city)
    assert_equal('19033', customer.zip)
    assert_equal('US', customer.country)
    assert_equal('PA', customer.state)
    assert_equal('55555555555', customer.phone)
    assert_equal('2016-03-24T15:19:10.7800694Z', customer.created)
  end

  def test_retrieve_customers_with_pagination
    stub_request(:get, 'https://api.alternativepayments.com/api/customers/?limit=3&offset=10').
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
                                          'customers' => [
                                              {
                                                  'id' => 'cus_7f0724f3b1d745d49',
                                                  'mode' => 'Live',
                                                  'firstName' => 'Jane',
                                                  'lastName' => 'Doe',
                                                  'email' => 'jane@doe.com',
                                                  'country' => 'DE',
                                                  'created' => '2015-06-24T11:46:35.303Z'
                                              },
                                              {
                                                  'id' => 'cus_15b154da474247dbb',
                                                  'mode' => 'Live',
                                                  'firstName' => 'John',
                                                  'lastName' => 'Doe',
                                                  'email' => 'john@doe.com',
                                                  'address' => 'Rutledge Ave 409',
                                                  'city' => 'Folsom',
                                                  'zip' => '19033',
                                                  'country' => 'US',
                                                  'phone' => '55555555555',
                                                  'created' => '2015-06-24T12:28:06.527Z'
                                              },
                                              {
                                                  'id' => 'cus_15b154da233sxcvby',
                                                  'mode' => 'Live',
                                                  'firstName' => 'John',
                                                  'lastName' => 'Wayne',
                                                  'email' => 'wayne.john@doe.com',
                                                  'address' => 'Wild Wild West',
                                                  'city' => 'Texas',
                                                  'zip' => '19033',
                                                  'country' => 'US',
                                                  'phone' => '55555555555',
                                                  'created' => '2015-06-24T12:28:06.527Z'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    customers = ApRubySdk::Customer.all(limit: 3, offset: 10)

    assert_equal(3, customers.length)

    first_customer = customers[0]

    assert_equal('cus_7f0724f3b1d745d49', first_customer.id)
    assert_equal('Live', first_customer.mode)
    assert_equal('Jane', first_customer.firstName)
    assert_equal('Doe', first_customer.lastName)
    assert_equal('jane@doe.com', first_customer.email)
    assert_nil(first_customer.address)
    assert_nil(first_customer.city)
    assert_nil(first_customer.zip)
    assert_equal('DE', first_customer.country)
    assert_nil(first_customer.state)
    assert_nil(first_customer.phone)
    assert_equal('2015-06-24T11:46:35.303Z', first_customer.created)

    second_customer = customers[1]

    assert_equal('cus_15b154da474247dbb', second_customer.id)
    assert_equal('Live', second_customer.mode)
    assert_equal('John', second_customer.firstName)
    assert_equal('Doe', second_customer.lastName)
    assert_equal('john@doe.com', second_customer.email)
    assert_equal('Rutledge Ave 409', second_customer.address)
    assert_equal('Folsom', second_customer.city)
    assert_equal('19033', second_customer.zip)
    assert_equal('US', second_customer.country)
    assert_nil(second_customer.state)
    assert_equal('55555555555', second_customer.phone)
    assert_equal('2015-06-24T12:28:06.527Z', second_customer.created)

    third_customer = customers[2]

    assert_equal('cus_15b154da233sxcvby', third_customer.id)
    assert_equal('Live', third_customer.mode)
    assert_equal('John', third_customer.firstName)
    assert_equal('Wayne', third_customer.lastName)
    assert_equal('wayne.john@doe.com', third_customer.email)
    assert_equal('Wild Wild West', third_customer.address)
    assert_equal('Texas', third_customer.city)
    assert_equal('19033', third_customer.zip)
    assert_equal('US', third_customer.country)
    assert_nil(third_customer.state)
    assert_equal('55555555555', third_customer.phone)
    assert_equal('2015-06-24T12:28:06.527Z', third_customer.created)
  end
end