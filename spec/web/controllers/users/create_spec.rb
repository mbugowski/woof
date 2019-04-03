RSpec.describe Web::Controllers::Users::Create, type: :action do
  let(:interactor) { instance_double("AddUser", call: nil) }
  let(:action) { described_class.new(interactor: interactor) }
  let(:user) { instance_double("User") }
  let(:valid_params) { Hash[name: "Test User", email: "test@example.com", password: "password"] }

  before do
    allow(interactor).to receive(:call).and_return(user)
  end

  describe "#call" do
    subject { action.call(params) }

    let(:warden) { instance_double("Warden::Proxy") }
    let(:params) { { :user => user_params, "warden" => warden } }

    before do
      allow(warden).to receive(:set_user).and_return(true)
    end

    context "with valid params" do
      let(:user_params) { valid_params }

      it "logs the user in" do
        expect(warden).to receive(:set_user).with(user)
        subject
      end

      it "redirects to home page" do
        response = action.call(params)
        expect(response[1]['Location']).to eq('/')
      end

      it "creates a new user record" do
        expect(interactor).to receive(:call).with(user_params)
        subject
      end
    end

    context "with missing name" do
      let(:user_params) { valid_params.merge(name: "") }

      it do
        response = action.call(params)
        expect(response[0]).to eq(422)
      end

      it "stores the correct error" do
        subject
        expect(action.params.errors[:user][:name]).to include("must be filled")
      end
    end

    context "with missing email" do
      let(:user_params) { valid_params.merge(email: "") }

      it do
        response = action.call(params)
        expect(response[0]).to eq(422)
      end

      it "stores the correct error" do
        subject
        expect(action.params.errors[:user][:email]).to include("must be filled")
      end
    end

    context "with invalid email" do
      let(:user_params) { valid_params.merge(email: "notanemail") }

      it do
        response = action.call(params)
        expect(response[0]).to eq(422)
      end

      it "stores the correct error" do
        subject
        expect(action.params.errors[:user][:email]).to eq(["is in invalid format"])
      end
    end

    context "with missing password" do
      let(:user_params) { valid_params.merge(password: "") }

      it do
        response = action.call(params)
        expect(response[0]).to eq(422)
      end

      it "stores the correct error" do
        subject
        expect(action.params.errors[:user][:password]).to include("must be filled")
      end
    end

    context "with a password that is too short" do
      let(:user_params) { valid_params.merge(password: "12345") }

      it do
        response = action.call(params)
        expect(response[0]).to eq(422)
      end

      it "stores the correct error" do
        subject
        expect(action.params.errors.dig(:user, :password)).to eq(["length must be within 6 - 64"])
      end
    end
  end
end
