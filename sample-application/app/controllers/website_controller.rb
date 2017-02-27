class WebsiteController < ApplicationController

  def create_phone_verification
    @phone_verification = ApRubySdk::PhoneVerification.create_phone_verification(
        {
            'phone' => '+15555555555'
        }
    )
  end

  def check_phone_verification_turned_on
    @payment_option = ApRubySdk::Website.is_phone_verification_on('SEPA')
  end

  def new
    is_phone_verification_on = ApRubySdk::Website.is_phone_verification_on('SEPA')

    if is_phone_verification_on.hasSmsVerification

      phone_verification = ApRubySdk::PhoneVerification.create_phone_verification(
          {
              'phone' => '+15555555555'
          }
      )
      phone_verification.pin = 1234

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

      @transaction = ApRubySdk::Transaction.create(
          'customer' => customer,
          'payment' => payment,
          'phoneverification' => phone_verification,
          'amount' => 500,
          'currency' => 'EUR',
          'description' => 'test sepa php sdk',
          'merchantPassThruData' => 'test_sepa_123',
          'iPAddress' => '127.0.0.1'
      )
    end
  end
end