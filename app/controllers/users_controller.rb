class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.user_stocks
    @stocks = @user.stocks
  end

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.user_stocks
    @stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    search_input = params[:search_input]

    @users_found = User.search(search_input)
    @users_found.delete(current_user) # removes the current user from the search
    if @users_found.count > 0
      render partial: "friends/lookup"
    else
      # doesn't do anything
      render status: :not_found, nothing: true
    end
  end

end
