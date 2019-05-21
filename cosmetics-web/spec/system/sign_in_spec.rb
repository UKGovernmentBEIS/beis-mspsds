require 'rails_helper'

RSpec.describe "After signing in", type: :system do
  let(:responsible_person) { create(:responsible_person) }

  after do
    sign_out
  end

  describe "a user without a Responsible Person account" do
    before do
      sign_in_as_business_user
    end

    it "is prompted to create or join an existing account" do
      assert_current_path account_path(:overview)
      assert_text "UK responsible person"
    end

    it "is redirected to create or join an account if attempting to access another page" do
      visit responsible_person_path(responsible_person)

      assert_current_path account_path(:overview)
      assert_text "UK responsible person"
    end
  end

  describe "a user associated with a Responsible Person account" do
    before do
      sign_in_as_member_of_responsible_person
    end

    it "is taken to the cosmetic products page" do
      assert_current_path responsible_person_notifications_path(responsible_person)
      assert_text "Your cosmetic products"
    end

    it "does not see options to create an account or sign in on the landing page" do
      visit root_path

      assert_no_text "Create an account"
      assert_no_text "sign in"
    end
  end

  describe "a Poison Centre user" do
    before do
      sign_in_as_poison_centre_user
    end

    it "is taken to the Poison Centre notifications page" do
      assert_current_path poison_centre_notifications_path
      assert_text "Search cosmetic products"
    end

    it "cannot access Responsible Person pages" do
      visit responsible_person_path(responsible_person)

      assert_current_path responsible_person_path(responsible_person)
      assert_text "Access denied"
    end
  end

private

  def sign_in_as_business_user
    user = create(:keycloak_test_user)
    sign_in as_user: user
  end

  def sign_in_as_member_of_responsible_person
    user = create(:keycloak_test_user)
    responsible_person.add_user user
    sign_in as_user: user
  end

  def sign_in_as_poison_centre_user
    user = create(:keycloak_poison_centre_user)
    sign_in as_user: user
  end

  def sign_in(as_user:)
    visit root_path
    click_on "Sign in"

    assert_text "Sign in to submit cosmetic product notifications"

    fill_in "Email address", with: as_user.email
    fill_in "Password", with: "password"
    click_on "Continue"
  end

  def sign_out
    click_on "Sign out"
  end
end