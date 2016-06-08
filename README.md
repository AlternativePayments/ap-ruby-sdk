# ap-ruby-sdk
Ruby SDK for AlternativePayments API

# Documenation for publishing gems with troubleshouting

Make your own gem: http://guides.rubygems.org/make-your-own-gem/
Publish your own gems: http://guides.rubygems.org/publishing/

Gem published: https://rubygems.org/gems/ap_ruby_sdk

# Content of application/SDK

1. `ap_ruby_sdk` folder contains SDK with source code containing tests.
	Usage:
```
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
```

	More read on: https://github.com/AlternativePayments/ap-ruby-sdk/tree/master/ap_ruby_sdk

2. `sample-application` folder contains Ruby On Rails sample application that uses SDK for communication with Alternative Payments server.
	Use it as any standard RoR application. If you have installed Ruby, Ruby On Rails then run `bundle install` and then `rails server` and access application on `https://localhost:3000`
More read on: https://github.com/AlternativePayments/ap-ruby-sdk/tree/master/sample-application
