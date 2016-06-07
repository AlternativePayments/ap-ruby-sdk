# ApRubySdk

Alternative Payments ruby gem sdk. Accept local payments from all over the world

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ap_ruby_sdk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ap_ruby_sdk

In your initializing files add line:

    if Rails.env.production?
      ApRubySdk.api_key = 'Live key provided from your AP account'
    else
      ApRubySdk.api_key = 'Test key provided from your AP account'
    end

## Usage

For usage and examples check `http://www.alternativepayments.com/support/api/` or sample-application on our open-source repo `https://github.com/AlternativePayments/ap-ruby-sdk`
Example of creating new customer:

    customer = ApRubySdk::Customer.create(
            {
                'firstName' => 'John',
                'lastName' => 'Doe',
                'email' => params[:email],
                'address' => 'Rutledge Ave 409',
                'city' => 'Folsom',
                'zip' => '19033',
                'country' => 'US',
                'state' => 'PA',
                'phone' => '55555555555',
                'created' => '2016-03-24T15:19:10.7800694Z'
            }
    )

Accessing object's attributes:

    customer.firstName
    => John

If you want to work with JSON:

    customer.to_json

Same goes for complex objects like Transaction.
Create SEPA transaction:

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
          'iban' => 'BE88271080782541'
    )

    transaction = ApRubySdk::Transaction.create(
          'customer' => customer,
          'payment' => payment,
          'amount' => 500,
          'currency' => 'EUR',
          'description' => 'test sepa php sdk',
          'merchantPassThruData' => 'test_sepa_123',
          'iPAddress' => '127.0.0.1'
    )

Access customer:

    transaction.customer.firstName

You can also create objects using only JSON:

    transaction = ApRubySdk::Transaction.create(
          'customer' => {
            'id' => 'cus_bd838e3611d34d598',
            'firstName' => 'John',
            'lastName' => 'Doe',
            'email' => 'john@doe.com',
            'country' => 'DE'
          },
          'payment' => {
            'paymentOption' => 'SEPA',
            'holder' => 'John Doe',
            'iban' => 'BE88271080782541'
          },
          'amount' => 500,
          'currency' => 'EUR',
          'description' => 'test sepa php sdk',
          'merchantPassThruData' => 'test_sepa_123',
          'iPAddress' => '127.0.0.1'
    )

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/AlternativePayments/ap-ruby-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
