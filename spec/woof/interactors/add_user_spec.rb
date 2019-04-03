RSpec.describe AddUser do
  let(:interactor) { described_class.new }
  let(:attributes) { Hash[name: "Test", email: "user@example.com", password: "password"] }

  before { UserRepository.new.clear }

  context "with good input" do
    let(:result) { interactor.call(attributes) }

    it "succeds" do
      expect(result.successful?).to be(true)
    end

    it "creates user with correct name and email" do
      expect(result.user.name).to eq("Test")
      expect(result.user.email).to eq("user@example.com")
    end
  end

  context "persistence" do
    let(:repository) { instance_double("UserRepository") }

    it "persists the User" do
      expect(repository).to receive(:create)
      AddUser.new(repository: repository).call(attributes)
    end
  end
end
