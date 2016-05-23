require 'test_helper'

class CustomerTest < Minitest::Test

  def test_create_customer
    stub_request(:post, 'https://api.alternaativepayments.com/api/customers').
        with(
            body:
                "id=cus_bd838e3611d34d598&mode=Live&firstName=John&lastName=Doe&email=john%40doe.com&address=Rutledge%20Ave%20409&city=Folsom&zip=19033&country=US&state=PA&phone=55555555555&created=2016-03-24T15%3A19%3A10.7800694Z",
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :content_length => '213',
                :user_agent => 'Ruby'
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
end