require 'swagger_helper'

RSpec.describe 'api/v1/transactions', type: :request do
  path '/api/v1/transactions' do
    get('list all transactions') do
      tags 'Transactions'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/transactions/{id}' do
    get 'Retrieves a transaction' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      response '200', 'transactions found' do
        schema type: :object,
          properties: {
            id: { type: :integer }
          },
          required: [ :id ]
        run_test!
      end

      response '404', 'transactions not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/api/v1/transactions/{id}' do
    delete 'Delete a transaction' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'Transaction found' do
        schema type: :object,
          properties: {
            id: { type: :integer }
          },
          required: [ 'id' ]
        run_test!
      end

      response '404', 'Transaction not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/api/v1/transactions' do
    post 'Creates a transactions' do
      tags 'Transactions'
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: 'transactions[customer_id]', in: :formData, type: :integer
      parameter name: 'transactions[amount_deposited]', in: :formData, type: :string
      parameter name: 'transactions[currency_deposited_id]', in: :formData, type: :integer
      parameter name: 'transactions[currency_pay_back_id]', in: :formData, type: :integer
      parameter name: 'transactions[transaction_date]', in: :formData, type: :string
      response '200', 'transactions created' do
        let(:transactions) { { name: 'Dodo', status: 'available' } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:transactions) { { name: 'foo' } }
        run_test!
      end
    end
  end


  path '/api/v1/transactions/{id}' do
    put 'Updates a transactions' do
      tags 'Transactions'
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'transactions[customer_id]', in: :formData, type: :integer
      parameter name: 'transactions[amount_deposited]', in: :formData, type: :string
      parameter name: 'transactions[currency_deposited_id]', in: :formData, type: :integer
      parameter name: 'transactions[currency_pay_back_id]', in: :formData, type: :integer
      parameter name: 'transactions[transaction_date]', in: :formData, type: :string
      response '201', 'transactions created' do
        let(:transactions) { { customer_id: '1', status: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:transactions) { { customer_id: '1' } }
        run_test!
      end
    end
  end

end
