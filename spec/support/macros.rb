def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user) ).id
end

def sign_in_paid_member(user=nil)
  session[:user_id] = (user || Fabricate(:user, membership_level: "paid") ).id
end
