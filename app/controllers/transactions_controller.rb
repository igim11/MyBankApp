class TransactionsController < ApplicationController

    def deposit
        @transaction = Transaction.new
    end

    def transfer
        @transaction = Transaction.new
    end

    def withdraw
        @transaction = Transaction.new
    end

    def create
        @transaction = Transaction.new(transaction_params)

        respond_to do |format|
            if @transaction.save
                update_user_cash(@transaction)
                if request.referer == transactions_deposit_url
                    format.html { redirect_to root_path, notice: "Successfully deposited #{'%.2f' % @transaction.amount}!" }
                elsif request.referer == transactions_transfer_url
                    format.html { redirect_to root_path, notice: "Successfully transferred #{'%.2f' % @transaction.amount} to #{@transaction.to_account}!" }
                else
                    format.html { redirect_to root_path, notice: "Successfully withdrew #{'%.2f' % @transaction.amount}!" }
                end
                format.json { render :show, status: :created, location: @transaction }
            else
                if request.referer == transactions_deposit_url
                    format.html { render :deposit, status: :unprocessable_entity }
                elsif request.referer == transactions_transfer_url
                    format.html { render :transfer, status: :unprocessable_entity }
                else
                    format.html { render :withdraw, status: :unprocessable_entity }
                end
                format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def update_user_cash(transaction)
        if transaction.action == 'Deposit'
            current_user.update(cash: current_user.cash + transaction.amount)
        end
    end

    def transaction_params
        params.require(:transaction).permit(:action, :amount, :to_account, :from_account)
    end
end