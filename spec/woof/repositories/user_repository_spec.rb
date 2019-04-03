RSpec.describe UserRepository, type: :repository do
  subject(:repository) { described_class.new }

  before { repository.clear }

  describe "#find_by_email" do
    subject { repository.find_by_email(email) }

    let(:email) { "tester@example.com" }

    context "when there is a user with the email" do
      let!(:user) { repository.create(email: email, name: "tester") }

      it { is_expected.to eq(user) }
    end

    context "when there is no user" do
      it { is_expected.to be_nil }
    end

    context "when there is a user with a different email" do
      let!(:user) { repository.create(email: "wrong@example.com", name: "tester") }

      it { is_expected.to be_nil }
    end
  end

  describe "#authenticate" do
    subject { repository.authenticate(email, password) }

    let(:email) { "tester@example.com" }
    let(:password) { "password" }

    context "when there is a user with the email" do
      let(:interactor) { AddUser.new(repository: repository) }
      let(:user_attributes) { Hash[email: email, name: "tester", password: password] }

      before { user }

      context "when the password matches" do
        let(:user) { interactor.call(Hash[email: email, name: "tester", password: password]).user }

        it { is_expected.to eq(user) }
      end

      context "when the password doesn't match" do
        let(:user) { interactor.call(Hash[email: email, name: "tester", password: "wrong"]).user }

        it { is_expected.to be_nil }
      end
    end

    context "when there is no user with the email" do
      it { is_expected.to be_nil }
    end
  end
end
