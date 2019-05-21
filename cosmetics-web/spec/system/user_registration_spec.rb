require 'rails_helper'

RSpec.describe "Account registration", type: :system do
  it "can be accessed from the landing page" do
    visit root_path
    click_on "Create an account"

    assert_text "Your details"
    assert_current_path(/auth\/realms\/opss\/protocol\/openid-connect\/registrations/)
  end

  it "can be accessed from the sign in page" do
    visit root_path
    click_on "Sign in"
    click_on "create an account"

    assert_text "Your details"
    assert_current_path(/auth\/realms\/opss\/login-actions\/registration\?client_id=cosmetics-app/)
  end

  it "succeeds with valid details" do
    create_new_account

    fill_in "Full name", with: "New User"
    fill_in "Work email address", with: "test@example.com"
    fill_in "Mobile phone number", with: "07797 900982"
    fill_in "Password", with: "complex_password"
    fill_in "Confirm password", with: "complex_password"
    click_on "Continue"

    assert_text "Check your email"
  end

private

  def create_new_account
    visit root_path
    click_on "Create an account"
  end
end