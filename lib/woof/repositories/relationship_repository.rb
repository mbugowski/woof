class RelationshipRepository < Hanami::Repository
  associations do
    belongs_to :user, as: :follower
    belongs_to :user, as: :followed
  end

  def find_relationship(follower:, followed:)
    relationships.where(follower_id: follower.id, followed_id: followed.id)
  end

  def find_following(user)
    relationships.where(follower_id: user.id)
  end

  def find_followers(user)
    relationships.where(followed_id: user.id)
  end
end
