require "bcrypt"

class User < Hanami::Entity
  def password
    BCrypt::Password.new(encrypted_password)
  end

  def following?(other_user)
    relationship_repository.find_relationship(follower: self, followed: other_user).to_a.any?
  end

  def follow(other_user)
    return if following?(other_user)

    relationship_repository.create(follower_id: id, followed_id: other_user.id)
  end

  def unfollow(other_user)
    to_delete = relationship_repository.find_relationship(follower: self, followed: other_user)
    to_delete.each do |relationship|
      relationship_repository.delete(relationship.id)
    end
  end

  def following
    relationship_repository.find_following(self)
  end

  def followers
    relationship_repository.find_followers(self)
  end

  private

  def relationship_repository
    RelationshipRepository.new
  end
end
