require "rails_helper"

RSpec.describe SearchUser, type: :model do
  subject(:user) { described_class.new(id: 123) }

  describe "#can_view_product_ingredients?" do
    context "when MSA user" do
      before { allow(user).to receive(:msa_user?).and_return(true) }

      it "returns false" do
        expect(user).not_to be_can_view_product_ingredients
      end
    end

    context "when not an MSA user" do
      before { allow(user).to receive(:msa_user?).and_return(false) }

      it "returns true" do
        expect(user).to be_can_view_product_ingredients
      end
    end
  end
end
