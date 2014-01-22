class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendship = Friendship.new
  end

  def create
    friend = User.find(params[:user_id])
    if current_user.add_friend(friend)
      flash.notice = "Your request to #{friend.username} has been sent!"
    else
      flash.notice = "Could not find that user!"
    end
    redirect_to :back
  end

  def approve
    find_pending_friendship.approve
    flash.notice = "Congrats on having a new friend! You're on your way to being a running social butterfly!"
    redirect_to :back
  end

  def remove
    find_friendship.remove
    flash.notice = "You just showed them who the boss was!"
    redirect_to :back
  end

  def reject
    find_pending_friendship.reject
    flash.notice = "REJECTED!!!"
    redirect_to :back
  end

  private

  def find_pending_friendship
    current_user.total_pending_friendships.detect { |friendship| friendship.id == params[:id].to_i }
  end

  def find_friendship
    current_user.total_approved_friendships.detect { |friendship| friendship.id == params[:id].to_i }
  end
end
