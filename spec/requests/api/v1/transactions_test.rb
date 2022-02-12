require 'rails_helper'
describe Api::V1::TransactionsController, type: :controller do
  describe ' controller test cases ' do
    let(:transaction1) { FactoryBot.create :transaction }
    describe '#show' do
      it 'should return the transaction with given id' do
        get :show, params: { id: transaction1.id }
        expect(transaction1).to be_valid
        expect(transaction1.first_name).to eq('John') 
        expect(transaction1.amount_pay_back).to eq(Concurrency.convert(100, 'USD', 'INR'))  
      end
      it 'should return not data found ' do
        get :show, params: { id: 12 }
        expect(response.status).to eq(404)
      end
    end
    describe '#index' do
      it 'should return the transaction with given id' do
        get :index
        expect(transaction1).to be_valid
      end
    end
    describe '#create' do
      let(:customer1) { FactoryBot.create :customer }
      let(:currency_dep) { FactoryBot.create :currency_deposited }
      let(:currency_pay) { FactoryBot.create :currency_pay_back }
      it 'should create a transaction' do
        post :create, params: {
          transactions: {
            customer_id: customer1.id,
            currency_deposited_id: currency_dep.id,
            currency_pay_back_id: currency_pay.id,
            transaction_date: '2/1/2022',
            amount_deposited: 100
          }
        }
        expect(JSON.parse(response.body)['message']).to eq('Successfully Created')
        expect(response.status).to eq(200)
      end
    end
    describe '#update' do
      let(:customer1) { FactoryBot.create :customer }
      it 'should update a transaction' do
        put :update, params: {
          id: transaction1.id,
          transactions: {
            amount_deposited: 1003
          }
        }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Successfully Updated')
      end
    end
    describe '#delete' do
      it 'should delete the transaction with given id' do
        delete :destroy, params: { id: transaction1.id }
        expect(response.status).to eq(200)
      end
      it 'should return not data found ' do
        delete :destroy, params: { id: 12 }
        expect(response.status).to eq(404)
      end
    end
  end 
end
