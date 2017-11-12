class PlanController < ApplicationController
  def new
  end

  def index
    if params[:plan_id]
      @plan = ApRubySdk::Plan.retrieve(params[:plan_id])
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

    flash[:notice] = plan.to_json
    redirect_to new_plan_url
  end

  def plans
    @plans = ApRubySdk::Plan.all
  end
end