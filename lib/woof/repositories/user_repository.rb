class UserRepository < Hanami::Repository
  associations do
    has_many :microposts
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
end
