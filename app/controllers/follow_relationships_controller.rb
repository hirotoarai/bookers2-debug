class FollowRelationshipsController < ApplicationController

  def create
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_back(fallback_location: follow_relationships_path)
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_back(fallback_location: follow_relationship_path)
  end

end
