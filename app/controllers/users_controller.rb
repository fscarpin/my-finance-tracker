class UsersController < ApplicationController
  def my_portfolio
    @stocks = current_user.stocks
    @user_stocks = current_user.user_stocks
    @user = current_user
  end
end
