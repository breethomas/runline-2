class FriendRequestUseCase

  def initialize(requester, receiver)
    @requester = requester
    @receiver = receiver
  end

  def process
    unless ApprovedFriends.new(@requester).friends.include?(@receiver)
      FriendRequestNotifier.request_friend(@receiver.email, @requester.username, "http://runline.tk").deliver
      Friendship.create(requester_id: @requester.id, receiver_id: @receiver.id, status: "pending")
    end
  end

end
