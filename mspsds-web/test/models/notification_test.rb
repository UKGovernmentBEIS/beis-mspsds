require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  setup do
    sign_in_as_user
    @investigation = Investigation.create(description: "new investigation for notification test")
    @original_source = @investigation.source
    @user_one = User.find_by(last_name: "User_one")
    @user_three = User.find_by(last_name: "User_three")
  end

  teardown do
    logout
  end

  test "should notify current assignee when the assignee is a person and there is any change" do
    @investigation.assignee = @user_one
    @investigation.save
    prepare_notify_check(who_will_be_notified: [@user_one])
    make_generic_change
  end

  test "should not notify anyone when the assignee is a team and there is any change done by team users" do
    @investigation.assignee = @user_one.teams[0]
    @investigation.save
    prepare_notify_check(who_will_be_notified: [])
    make_generic_change
  end

  test "should notify all team members when the assignee is a team and there is any change done by outsiders" do
    @investigation.assignee = @user_three.teams[0]
    @investigation.save
    prepare_notify_check(who_will_be_notified: [@user_three])
    make_generic_change
  end

  test "should notify creator when case is closed or reopened by someone else" do
    logout
    sign_in_as_admin
    @investigation.source = @original_source
    prepare_notify_check(who_will_be_notified: [@user_one])
    @investigation.is_closed = !@investigation.is_closed
    @investigation.save
    @investigation.is_closed = !@investigation.is_closed
    @investigation.save
  end

  test "should not notify creator when case is closed or reopened by the creator" do
    prepare_notify_check(who_will_be_notified: [])
    @investigation.is_closed = !@investigation.is_closed
    @investigation.save
    @investigation.is_closed = !@investigation.is_closed
    @investigation.save
  end

  def prepare_notify_check(who_will_be_notified: [])
    result = "aaa"
    allow(result).to receive(:deliver_later)
    allow(NotifyMailer).to receive(:updated_investigation) do |id, user_name, _user_email, _text|
      assert_equal id, @investigation.id
      assert_includes who_will_be_notified.map{|user| user.full_name}, user_name
      assert_not_includes (User.all - who_will_be_notified).map{|user| user.full_name}, user_name
      result
    end
  end

  def make_generic_change
    # Should not be changing the assignee, since it's a special case
    @investigation.businesses << Business.new(trading_name: 'Test Company')
  end
end
