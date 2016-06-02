class RefundController < ApplicationController
  def new
  end

  def index
    if params[:refund_id] && params[:transaction_id]
      @refund = ApRubySdk::Transaction.retrieve_refund(params[:refund_id], params[:transaction_id])
    end
  end

  def create
    refund = ApRubySdk::Transaction.refund(ApRubySdk::RefundReason::FRAUD, params[:transaction_id])

    flash[:notice] = refund.to_json
    redirect_to new_refund_url
  end

  def refunds
    if params[:transaction_id]
      @refunds = ApRubySdk::Transaction.refunds(params[:transaction_id])
    end
  end
end