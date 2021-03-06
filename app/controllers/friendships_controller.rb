class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:user_id])
    if FriendRequestUseCase.new(current_user, friend).process
      flash[:notice] = {:class => "flash", :body => "Your request to #{friend.username} has been sent!"}
    else
      flash[:notice] = {:class =>  "flash", :body => "Could not find that user!"}
    end
    redirect_to :back
  end

  def approve
    ApproveFriendUseCase.new(current_friendship).process
    flash[:notice] = {:class => "flash", :body => "Congrats on having a new friend! You're on your way to being a running social butterfly!"}
    redirect_to :back
  end

  def remove
    RemoveFriendshipUseCase.new(current_friendship).process
    flash[:notice] = {:class => "flash", :body => "You just showed them who the boss was!"}
    redirect_to :back
  end

  private

  def current_friendship
    AllFriendships.new(current_user).friends.detect {|friendship| friendship.id == params[:id].to_i}
  end

end
