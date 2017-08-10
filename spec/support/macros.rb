def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user) ).id
end

def sign_in_paid_member(user=nil)
  session[:user_id] = (user || Fabricate(:user, membership_level: "paid") ).id
end

def sign_in_free_member(user=nil)
  session[:user_id] = (user || Fabricate(:user, membership_level: "free") ).id
end

def sign_in_admin(user=nil)
    session[:user_id] = (user || Fabricate(:user, membership_level: "free", role: "admin") ).id
end
