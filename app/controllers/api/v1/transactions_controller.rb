class Api::V1::TransactionsController < ApplicationController
	before_action :set_transaction,  only: [:update, :show, :destroy]  
	
	# POST /api/v1/transactions
	def create
		transaction = Transaction.new(transactions_params)
		transaction.amount_pay_back = transaction.amount_pay_back_to_customers
    if transaction.save
      render json:  { message: I18n.t('api.transactions.successfully_created'), 'Transactions': transaction.to_api_json}, status: 200 
    else
      render json: transaction.errors,status: :unprocessable_entity
    end
	end

	# GET /api/v1/transactions
	def index
		transactions = Transaction.all.map{|transaction| transaction.to_api_json}
    if transactions
      render json:  { message: I18n.t('api.transactions.data_found'), 'Transactions': transactions}, status: 200 
    else
      render json:  { message: I18n.t('api.transactions.no_data_found')} ,status: 404
    end
	end

	# PUT /api/v1/transactions/:id
	def update
    @transaction.update(transactions_params)
    @transaction.amount_pay_back = @transaction.amount_pay_back_to_customers
    if @transaction.save
      render json:  { message: I18n.t('api.transactions.data_found'), 'Transactions': @transaction.to_api_json}, status: 200 
    else
    	render json: @transaction.errors,status: :unprocessable_entity
    end
  end


	# GET /api/v1/transactions/:id
	def show
    if @transaction
      render json:  { message: I18n.t('api.transactions.data_found'), 'Transactions': 	@transaction.to_api_json}, status: 200 
    end
	end

	# DELETE /api/v1/transactions/:id
	def destroy
    if @transaction
    	@transaction.destroy
      render json:  { message: I18n.t('api.transactions.successfully_deleted')}, status: 200 
    end
	end

	
	private

	def set_transaction
		@transaction = Transaction.find_by_id params[:id]
		if @transaction.blank?
      render json: { message: I18n.t('api.transactions.no_data_found') },
             status: :not_found
      return false
    end
	end

	def transactions_params
		params.require(:transactions).permit(:customer_id, :amount_deposited, :currency_deposited_id, :currency_pay_back_id, :transaction_date)
	end
end
