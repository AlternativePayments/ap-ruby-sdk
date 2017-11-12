class SubscriptionController < ApplicationController
  def new
  end

  def index
    if params[:subscription_id]
      @subscription = ApRubySdk::Subscription.retrieve(params[:subscription_id])
    end
  end

  def create
    plan = ApRubySdk::Plan.create(
        {
            'intervalCount' => 1,
            'intervalUnit' => ApRubySdk::Period::DAY,
            'amount' => params[:plan_amount],
            'currency' => 'EUR',
            'name' => params[:plan_name],
            'description' => 'Test plan',
            'billingCycles' => 12,
            'isConversionRateFixed' => true,
            'ipAddress' => '91.218.229.20',
            'trialPeriod' => 7
        }
    )

    customer = ApRubySdk::Customer.new(
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => params[:email],
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'iban' => 'DE89370400440532013000'
    )

    phoneverification = ApRubySdk::PhoneVerification.create(
        'phone' => '+15555555555',
        'key' => ApRubySdk.api_public_key
    )

    transaction_phoneverification = ApRubySdk::PhoneVerification.new(
        'phone' => phoneverification.phone,
        'key' => ApRubySdk.api_public_key,
        'token' => phoneverification.token,
        'pin' => 1234
    )

    transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'description' => 'test sepa php sdk',
        'merchantPassThruData' => 'test_sepa_123',
        'ipAddress' => '127.0.0.1',
        'phoneverification' => transaction_phoneverification
    )

    subscription = ApRubySdk::Subscription.create(
        {
            'quantity' => 2,
            'ipAddress' => '91.218.229.20',
            'paymentId' => transaction.payment.id,
            'customerId' => transaction.customer.id,
            'planId' => plan.id,
            'phoneverification' => transaction_phoneverification
        }
    )

    flash[:notice] = subscription.to_json
    redirect_to new_subscription_url
  end

  def subscriptions
    @subscriptions = ApRubySdk::Subscription.all
  end
end