require 'rails_helper'

RSpec.describe PoisonCentres::NotificationsController, type: :controller do
  let(:responsible_person_1) { create(:responsible_person, email_address: "one@example.com") }
  let(:responsible_person_2) { create(:responsible_person, email_address: "two@example.com") }

  let(:rp_1_notifications) { create_list(:registered_notification, 3, responsible_person: responsible_person_1) }
  let(:rp_2_notifications) { create_list(:registered_notification, 3, responsible_person: responsible_person_2) }

  after do
    sign_out
  end

  describe "When signed in as a Poison Centre user" do
    before do
      sign_in_as_poison_centre_user
    end

    describe "GET #index" do
      before do
        @notifications = rp_1_notifications + rp_2_notifications
        @draft_notification = create(:draft_notification, responsible_person: responsible_person_1)
        @imported_notification = create(:imported_notification, responsible_person: responsible_person_1)
        Notification.import force: true
        get :index
      end

      it "gets all registered notifications" do
        expect(assigns(:notifications).records.to_a.sort).to eq(@notifications.sort)
      end

      it "excludes draft notifications" do
        expect(assigns(:notifications).records.to_a).not_to include(@draft_notification)
      end

      it "excludes unfinished imported notifications" do
        expect(assigns(:notifications).records.to_a).not_to include(@imported_notification)
      end

      it "renders the index template" do
        expect(response).to render_template("notifications/index")
      end
    end

    describe "search on #index" do
      before do
        @unique_notification = create(:registered_notification, responsible_person: responsible_person_1, product_name: "bbbb")
        @similar_notification_one = create(:registered_notification, responsible_person: responsible_person_1, product_name: "aaaa")
        @similar_notification_two = create(:registered_notification, responsible_person: responsible_person_1, product_name: "aaab")
        Notification.import force: true
      end

      it "finds the correct notification" do
        get :index, params: { q: "bbbb" }
        expect(assigns(:notifications).records.to_a).to eq([@unique_notification])
      end

      it "finds similar notifications with fuzzy search" do
        get :index, params: { q: "aaaa" }
        expect(assigns(:notifications).records.to_a.sort).to eq([@similar_notification_one, @similar_notification_two].sort)
      end
    end

    describe "GET #show" do
      let(:notification) { rp_1_notifications.first }

      it "assigns the correct notification" do
        get :show, params: { reference_number: notification.reference_number }
        expect(assigns(:notification)).to eq(notification)
      end

      it "renders the show template" do
        get :show, params: { reference_number: notification.reference_number }
        expect(response).to render_template("notifications/show")
      end
    end
  end

  describe "When signed in as a Responsible Person user" do
    before do
      sign_in_as_member_of_responsible_person(responsible_person_1)
    end

    describe "GET #index" do
      it "raises NotAuthorizedError" do
        expect {
          get :index
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    describe "GET #show" do
      it "raises NotAuthorizedError" do
        expect {
          get :show, params: { reference_number: rp_1_notifications.first.reference_number }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
