require 'grape'

require './controller/wallet'

module Routes
  class Wallets < Grape::API
    namespace :wallets do
      post do
        process_request do
          Controller::Wallet.create
        end
      end

      route_param :wallet_id do
        params do
          requires :wallet_id, type: Integer
        end
        get do
          process_request do
            Controller::Wallet.find(params[:wallet_id])
          end
        end

        params do
          requires :amount, type: Float
          requires :wallet_id, type: Integer
        end
        post :take_money do
          process_request do
            wallet = Controller::Wallet.find(params[:wallet_id])
            wallet.take_money(params[:amount])
          end
        end

        params do
          requires :amount, type: Float
          requires :wallet_id, type: Integer
        end
        post :receive_money do
          process_request do
            wallet = Controller::Wallet.find(params[:wallet_id])
            wallet.receive_money(params[:amount])
          end
        end
      end
    end
  end
end
