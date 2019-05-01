require "hanami/interactor"

class AddMicropost
  include Hanami::Interactor

  expose :micropost

  def initialize(repository: MicropostRepository.new)
    @repository = repository
  end

  def call(micropost_attributes)
    @micropost = @repository.create(micropost_attributes)
  end
end
