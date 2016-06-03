class CustomerController < ApplicationController
  def new
  end

  def index
    if params[:customer_id]
      @customer = ApRubySdk::Customer.retrieve(params[:customer_id])
    end
  end

  def create
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

    flash[:notice] = customer.to_json
    redirect_to new_customer_url
  end

  def customers
    @customers = ApRubySdk::Customer.all
  end
end
