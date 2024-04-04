class AccountController < ApplicationController
    before_action :authenticate_user!

    def index
        @available_balance = '%.2f' % current_user.cash
    end
end