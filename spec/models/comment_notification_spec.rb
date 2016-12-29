require "spec_helper"

describe CommentNotification do

  describe ".all_unread" do
    it "should return only the unread notifications" do
      read_1 = Fabricate(:comment_notification, read: true)
      read_2 = Fabricate(:comment_notification, read: true)
      read_3 = Fabricate(:comment_notification, read: true)
      read_4 = Fabricate(:comment_notification, read: true)
      unread_1 = Fabricate(:comment_notification, read: false)
      unread_2 = Fabricate(:comment_notification, read: false, created_at: 1.day.ago)
      unread_3 = Fabricate(:comment_notification, read: false, created_at: 2.days.ago)
      unread_4 = Fabricate(:comment_notification, read: false, created_at: 3.days.ago)
      unread_5 = Fabricate(:comment_notification, read: false, created_at: 4.days.ago)
      expect(CommentNotification.all_unread).to match_array([unread_1, unread_2, unread_3, unread_4, unread_5])
    end
  end

  describe ".mark_all_as_read" do
    it "should mark all notifications as read" do
      read_1 = Fabricate(:comment_notification, read: true)
      read_2 = Fabricate(:comment_notification, read: true)
      read_3 = Fabricate(:comment_notification, read: true)
      read_4 = Fabricate(:comment_notification, read: true)
      unread_1 = Fabricate(:comment_notification, read: false)
      unread_2 = Fabricate(:comment_notification, read: false)
      unread_3 = Fabricate(:comment_notification, read: false)
      unread_4 = Fabricate(:comment_notification, read: false)
      unread_5 = Fabricate(:comment_notification, read: false)
      CommentNotification.mark_all_as_read
      expect(CommentNotification.all_unread.length).to eq(0)
    end
  end

  describe "#toggle_read" do
    it "should change the notification's read to false if it is true" do
      notification = Fabricate(:comment_notification)
      notification.toggle_read
      expect(notification.read).to be_truthy
    end

    it "should change the notification's read to true if it is false" do
      notification = Fabricate(:comment_notification, read: true)
      notification.toggle_read
      expect(notification.read).to be_falsey
    end
  end

  describe "#mark_as_read" do
    it "should change read to true if read is false" do
      notification = Fabricate(:comment_notification, read: false)
      notification.mark_as_read
      expect(notification.read?).to be_truthy
    end

    it "should not update the record if it is already false" do
      notification = Fabricate(:comment_notification, read: true)
      notification.mark_as_read
      expect(notification.read?).to be_truthy
    end
  end


end