class VoidController < ApplicationController
  def new
  end

  def index
    if params[:void_id] && params[:transaction_id]
      @void = ApRubySdk::Transaction.retrieve_void(params[:void_id], params[:transaction_id])
    end
  end

  def create
    void = ApRubySdk::Transaction.void(ApRubySdk::RefundReason::FRAUD, params[:transaction_id])

    flash[:notice] = void.to_json
    redirect_to new_void_url
  end

  def voids
    if params[:transaction_id]
      @voids = ApRubySdk::Transaction.voids(params[:transaction_id])
    end
  end
end