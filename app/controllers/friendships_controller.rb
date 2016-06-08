class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:id])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "#{friend.full_name} has been added to your friends."
    else
      flash[:error] = "There was an error adding a friend."
    end

    redirect_to(my_friends_path)
  end

  def destroy
    friend_id = params[:id]
    @friendship = current_user.friendships.find_by(friend_id: friend_id)

    if @friendship.destroy
      flash[:notice] = "You are no longer friends with #{User.find(friend_id).full_name}"
      redirect_to my_friends_path
    end
  end
end
