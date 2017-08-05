
[1mFrom:[0m /home/josh/Desktop/web_dev/yingwenxuexiao/app/controllers/admin/dashboard/reports/reports_controller.rb @ line 13 Admin::Dashboard::Reports::ReportsController#payments:

     [1;34m7[0m: [32mdef[0m [1;34mpayments[0m
     [1;34m8[0m:   add_breadcrumb [31m[1;31m"[0m[31mDashboard[1;31m"[0m[31m[0m, admin_dashboard_path
     [1;34m9[0m:   add_breadcrumb [31m[1;31m"[0m[31mReports[1;31m"[0m[31m[0m, admin_dashboard_reports_reports_path
    [1;34m10[0m:   start_date = params[[31m[1;31m"[0m[31mstart_date[1;31m"[0m[31m[0m]
    [1;34m11[0m:   end_date = params[[31m[1;31m"[0m[31mend_date[1;31m"[0m[31m[0m]
    [1;34m12[0m:   [32mif[0m params[[31m[1;31m"[0m[31mfilter[1;31m"[0m[31m[0m] == [31m[1;31m"[0m[31mtrue[1;31m"[0m[31m[0m && !start_date.blank? && !end_date.blank?
 => [1;34m13[0m:     binding.pry
    [1;34m14[0m:     @payments = [1;34;4mPayment[0m.where([35mcreated_at[0m: [1;34;4mTime[0m.at(start_date).beginning_of_day..[1;34;4mTime[0m.at(end_date).end_of_day)
    [1;34m15[0m:   [32melse[0m
    [1;34m16[0m:     @payments = [1;34;4mPayment[0m.all
    [1;34m17[0m:   [32mend[0m
    [1;34m18[0m: [32mend[0m

