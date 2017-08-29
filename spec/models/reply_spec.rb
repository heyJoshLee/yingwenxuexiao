require "spec_helper"

describe Reply do

  describe ".create" do

    context "reply to comment on lesson" do
      let!(:student)    { Fabricate(:user, name: "Alice") }
      let!(:student_2)  { Fabricate(:user, name: "Bob") }
      let!(:lesson)     { Fabricate(:lesson) }
      let!(:comment)  { Fabricate(:comment, author: student, commentable_type: "Lesson", commentable_id: lesson.id) }
      let!(:reply) { Fabricate(:reply, comment_id: comment.id, author: student_2) }


      it "creates a Notification" do
        expect(Notification.count).to eq(1)
      end

      it "adds notification to original comment author" do
        expect(student.notifications.count).to eq(1)
      end

      it "creates a notification for the original poster" do
        expect(Notification.last.receiver_id).to eq(student.id)
        expect(Notification.last.sender_id).to eq(student_2.id)
      end

      it "adds relevant information to the notification" do
        expect(Notification.last.subject).to eq("#{student_2.name} just replied to your comment.")

      end

      it "add link for lesson comment" do
        expect(Notification.last.body).to eq(%Q{
      "#{student_2.name}" just replied to your comment.<br/><br/>
      "#{reply.body}"<br/><br/>
      <a href='#{ENV["ROOT_URL"]}/courses/#{comment.commentable.course.slug}/lessons/#{comment.commentable.slug}' > View the comment </a>})
      end
    end

    context "reply to comment on an article" do
      let!(:student)    { Fabricate(:user, name: "Alice") }
      let!(:student_2)  { Fabricate(:user, name: "Bob") }
      let!(:article)     { Fabricate(:article) }
      let!(:comment)  { Fabricate(:comment, author: student, commentable_type: "Article", commentable_id: article.id) }
      let!(:reply) { Fabricate(:reply, comment_id: comment.id, author: student_2) }


      it "add link for article comment" do
        expect(Notification.last.body).to eq(%Q{
      "#{student_2.name}" just replied to your comment.<br/><br/>
      "#{reply.body}"<br/><br/>
      <a href='#{ENV["ROOT_URL"]}/articles/#{article.slug}' > View the comment </a>})
      end

    end
    
  end

end