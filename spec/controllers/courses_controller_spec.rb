require "rails_helper"

describe CoursesController do

  describe "GET show" do
    let!(:free_published_course) { Fabricate(:course, published: true, premium_course: false) }
    let!(:lesson_1) { Fabricate(:lesson, course_id: free_published_course.id, published: true) }
    let!(:lesson_2) { Fabricate(:lesson, course_id: free_published_course.id, published: true) }
    let!(:lesson_3) { Fabricate(:lesson, course_id: free_published_course.id) }

    let!(:free_unpublished_course) { Fabricate(:course, premium_course: false) }
    let!(:lesson_4) { Fabricate(:lesson, course_id: free_unpublished_course.id, published: true) }
    let!(:lesson_5) { Fabricate(:lesson, course_id: free_unpublished_course.id, published: true) }
    let!(:lesson_6) { Fabricate(:lesson, course_id: free_unpublished_course.id) }


    let!(:paid_published_course) { Fabricate(:course, published: true, premium_course: true) }
    let!(:lesson_7) { Fabricate(:lesson, course_id: paid_published_course.id, published: true) }
    let!(:lesson_8) { Fabricate(:lesson, course_id: paid_published_course.id, published: true) }
    let!(:lesson_9) { Fabricate(:lesson, course_id: paid_published_course.id) }

    let!(:paid_unpublished_course) { Fabricate(:course, premium_course: true) }
    let!(:lesson_10) { Fabricate(:lesson, course_id: paid_unpublished_course.id, published: true) }
    let!(:lesson_11) { Fabricate(:lesson, course_id: paid_unpublished_course.id, published: true) }
    let!(:lesson_12) { Fabricate(:lesson, course_id: paid_unpublished_course.id) }

    context "not logged in" do
      it_behaves_like "requires sign in" do
        let(:action) { get :show, id: free_published_course.slug }
      end

      it_behaves_like "unpublished course or lesson for paid" do
        let(:action) { get :show, id: paid_unpublished_course.slug }
      end

      it_behaves_like "unpublished course or lesson for free" do
        let(:action) { get :show, id: free_unpublished_course.slug }
      end
    end

    context "free user logged in" do
      before do
        sign_in_free_member
      end

      it_behaves_like "unpublished course or lesson for paid" do
        let(:action) { get :show, id: paid_unpublished_course.slug }
      end

      it_behaves_like "unpublished course or lesson for free" do
        let(:action) { get :show, id: free_unpublished_course.slug }
      end


      it_behaves_like "free user signs in but requires premium member" do
        let(:action) { get :show, id: paid_published_course.slug }
      end

      it "should assign course if the course is free" do
        get :show, id: free_published_course.slug
        expect(assigns(:course)).to eq(free_published_course)
      end
    end #free user logged in

    context "with paid member logged in" do
      before do
        sign_in_paid_member
      end

      it_behaves_like "unpublished course or lesson for paid" do
        let(:action) { get :show, id: paid_unpublished_course.slug }
      end

      it_behaves_like "unpublished course or lesson for free" do
        let(:action) { get :show, id: free_unpublished_course.slug }
      end

      it "assigns @course for free courses" do
        get :show, id: free_published_course.slug
        expect(assigns(:course)).to eq(free_published_course)
      end

      it "assigns @course for paid courses" do
        get :show, id: paid_published_course.slug
        expect(assigns(:course)).to eq(paid_published_course)
      end
    end #with paid member logged in

  end # GET show





  describe "GET index" do
    let!(:free_published_course) { Fabricate(:course, published: true, premium_course: false) }
    let!(:free_unpublished_course) { Fabricate(:course, premium_course: false) }
    let!(:paid_published_course) { Fabricate(:course, published: true, premium_course: true) }
    let!(:paid_unpublished_course) { Fabricate(:course, premium_course: true) }

    before do
      get :index
    end

    it "assigns @free_courses" do
      expect(assigns(:free_courses)).to eq([free_published_course])
    end

    it "assigns @premium_courses" do
      expect(assigns(:premium_courses)).to eq([paid_published_course])
    end
  end # GET index

  describe "POST enroll" do
    let!(:free_published_course) { Fabricate(:course, published: true, premium_course: false) }
    let!(:free_unpublished_course) { Fabricate(:course, premium_course: false) }
    let!(:paid_published_course) { Fabricate(:course, published: true, premium_course: true) }
    let!(:paid_unpublished_course) { Fabricate(:course, premium_course: true) }
    let!(:free_user) { Fabricate(:user)}
    let!(:paid_user) { Fabricate(:user, membership_level: "paid")}

    context "not logged in" do
      it_behaves_like "requires sign in" do
        let(:action) { post :enroll, id: free_published_course.slug}
      end 
    end

    context "free user logged in enrolling in free class" do
      before do
        sign_in_free_member(free_user)
      end

      it "adds the class to user's classes" do
        post :enroll, id: free_published_course.slug
        expect(free_user.courses).to include(free_published_course)
      end

      it "redirects to class's page" do
        post :enroll, id: free_published_course.slug
        expect(response).to redirect_to course_path(free_published_course)
      end

      it_behaves_like "unpublished course or lesson for free" do
        let(:action) { post :enroll, id: free_unpublished_course.slug }
      end
    end # free user logged in enrolling in free class

    context "free user logged in enrolling in premium class" do
      before do
        sign_in_free_member(free_user)
      end 

      it "does not add class to the user's classes" do
        post :enroll, id: paid_published_course.slug
        expect(free_user.courses).not_to include(paid_published_course)
      end

      it_behaves_like "free user signs in but requires premium member" do
        let(:action) { post :enroll, id: paid_published_course.slug}
      end

      it_behaves_like "unpublished course or lesson for free" do
        let(:action) { post :enroll, id: free_unpublished_course.slug}
      end

    end #free user logged in enrolling in premium class



    context "with paid member logged in" do
      before do
        sign_in_paid_member(paid_user)
        post :enroll, id: paid_published_course.slug
      end

      it "adds the class to user's classes" do
        expect(paid_user.courses).to include(paid_published_course)
      end

      it "redirects to class's page" do
        expect(response).to redirect_to course_path(paid_published_course)
      end
    end # with paid member logged in

  end #POST enroll

end
  