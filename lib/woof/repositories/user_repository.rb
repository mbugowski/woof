class UserRepository < Hanami::Repository
  associations do
    has_many :microposts
    has_many :relationships, foreign_key: :follower_id, as: :followers
    has_many :users, through: :relationships, foreign_key: :followed_id, as: :followed
  end

  def find_by_email(email)
    users.where(email: email).first
  end

  def authenticate(email, password)
    user = find_by_email(email)
    user && user.password == password ? user : nil
  end

  def count(_)
    users.count
  end

  def page(offset, size)
    users.offset(offset).limit(size).to_a
  end

  def find_with_microposts(id)
    aggregate(:microposts).where(id: id).as(User).one
  end

  def find_followers(id)
    users.read("SELECT users.* FROM relationships INNER JOIN users ON relationships.follower_id = users.id WHERE relationships.followed_id = #{id}")
  end

  def find_following(id)
    users.read("SELECT users.* FROM relationships INNER JOIN users ON relationships.followed_id = users.id WHERE relationships.follower_id = #{id}")
  end
end
