class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.user_stocks
    @stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.user_stocks
    @stocks = @user.stocks
  end

end
