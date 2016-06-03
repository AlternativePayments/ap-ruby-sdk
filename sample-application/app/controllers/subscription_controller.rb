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
            'interval' => 1,
            'period' => ApRubySdk::Period::DAY,
            'amount' => params[:plan_amount],
            'currency' => 'EUR',
            'name' => params[:plan_name],
            'description' => 'Test plan'
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

    subscription = ApRubySdk::Subscription.create(
        {
            'paymentId' => transaction.payment.id,
            'customerId' => transaction.customer.id,
            'planId' => plan.id
        }
    )

    flash[:notice] = subscription.to_json
    redirect_to new_subscription_url
  end

  def subscriptions
    @subscriptions = ApRubySdk::Subscription.all
  end
end