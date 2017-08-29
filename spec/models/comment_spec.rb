require "spec_helper"

describe Comment do
  it { should validate_presence_of(:body)}
  it { should belong_to(:author) }
  it { should belong_to(:commentable) }
  it { should have_many(:replies) }


  describe ".create"  do

    it "it doesn't create a commentNotification if there are no admins" do
      Fabricate(:comment)
      expect(CommentNotification.count).to eq(0)
    end

    it "creates one notification if there is one admin" do
      Fabricate(:user, role: "admin")
      Fabricate(:comment)
      expect(CommentNotification.count).to eq(1)
    end

    it "creates three notifications if there are three admins" do
      Fabricate(:user)
      3.times do 
        Fabricate(:user, role: "admin")
      end
      Fabricate(:comment)
      expect(CommentNotification.count).to eq(3)
    end

    it "associates the commentNotificaiton with the admin" do
      admin = Fabricate(:user, role: "admin")
      Fabricate(:comment)
      expect(CommentNotification.last.user).to eq(admin)
    end

    it "creates a message for the commentNotification" do
      admin = Fabricate(:user, role: "admin")
      article = Fabricate(:article, title: "This is an Article")
      user = Fabricate(:user, name: "Alice")
      comment = Fabricate(:comment, author: user, commentable_id: article.id, commentable_type: "Article", body: "Nice article.")
      expect(CommentNotification.last.message).to eq("New comment on article #{article.title}. #{comment.author.name} says '#{comment.body}'.")
    end
  end

  describe ".delete" do

    it "destroys all comment notifications related to the comment for an article" do
      admin = Fabricate(:user, role: "admin")
      article = Fabricate(:article, title: "This is an Article")
      user = Fabricate(:user, name: "Alice")
      comment = Fabricate(:comment, author: user, commentable_id: article.id, commentable_type: "Article", body: "Nice article.")
      expect(CommentNotification.count).to eq(1)
      comment.destroy
      expect(CommentNotification.count).to eq(0)      
    end

    it "destroys all comment notifications related to the comment for a lesson" do
      admin = Fabricate(:user, role: "admin")
      admin_2 = Fabricate(:user, role: "admin")
      admin_3 = Fabricate(:user, role: "admin")
      lesson = Fabricate(:lesson, name: "This is an Article")
      user = Fabricate(:user, name: "Alice")
      comment = Fabricate(:comment, author: user, commentable_id: lesson.id, commentable_type: "Lesson", body: "Nice article.")
      expect(CommentNotification.count).to eq(3)
      comment.destroy
      expect(CommentNotification.count).to eq(0)      
    end

  end
end