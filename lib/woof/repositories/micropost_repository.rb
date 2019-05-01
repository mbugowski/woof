class MicropostRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  def count_for_user(user_id)
    microposts.where(user_id: user_id).count
  end
end
