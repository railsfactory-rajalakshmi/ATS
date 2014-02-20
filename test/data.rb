 
 
 
 
 class Data
	
	
	def self.login_elements
	OpenStruct.new(:sign_in_link=>"Sign in",:username_id=>"username",:password_id=>"password",:submit_id=>"login_submit_id")
end

def self.dashboard_elements
	OpenStruct.new(:my_account_class =>"my-account")
	end

def self.myaccounts_elements
	OpenStruct.new(:fname_id =>"user_firstname", :lname_id =>"user_lastname",:mail_id =>"user_mail", :lang_id=>"user_language", :mail_notification_id=>"user_mail_notification", :pref_notified_id=>"pref_no_self_notified", :pref_mail=>"pref_hide_mail",:zone=>"pref_time_zone",:sorting=>"pref_comments_sorting",:unsaved=>"pref_warn_on_leaving_unsaved", :acct_id=>"myaccount_id")
	end


def self.project_elements
		OpenStruct.new(:link=>"Projects",:id=>"project_id4",:bug_link=>"Bug",:new_issue =>"New issue",:itracker_id=>"issue_tracker_id",:subject_id=>"issue_subject",:description_id => "issue_description",:bold_class=>"jstb_strong",:status_id=>"issue_status_id",:priority_id=>"issue_priority_id",:assign_id=>"issue_assigned_to_id",:date_img=>"ui-datepicker-trigger",:date_css=>"img.ui-datepicker-trigger",:date=>"14",:year_cl=>"ui-datepicker-year",:dpick_image=>"#due_date_area > img.ui-datepicker-trigger", :month_css	=>"ui-datepicker-month",:est_hours=>"issue_estimated_hours",:done_id=>"issue_done_ratio",:submit=>"commit")
	
	end


def self.user_data
	OpenStruct.new(:username => "rajalakshmi", :password=>"123456789", :firstname=>'Rajalakshmi', :lastname=>'Shanmugam',:mail=>'rajalakshmi@railsfactory.com', :language=>'English', :mail_notification=>"No events",:pref_time_zone=>"(GMT-10:00) Hawaii",:pref_comments_sorting=>"In reverse chronological order")
			
			end


def self.user_data
	OpenStruct.new(:username => "rajalakshmi", :password=>"123456789", :firstname=>'Rajalakshmi', :lastname=>'Shanmugam',:mail=>'rajalakshmi@railsfactory.com', :language=>'English', :mail_notification=>"No events",:pref_time_zone=>"(GMT-10:00) Hawaii",:pref_comments_sorting=>"In reverse chronological order")
			
		end
		
		
		def self.project_data
	OpenStruct.new(:tracker => "Feature",:subject=>"IE error",:desc=>"IE error description",:status=>"New"	, :priority =>"Urgent", :assigne=>"Rajalakshmi Shanmugam", :start_year=>"2012" , :start_month =>"May", :date=>"5", :due_year =>"2014", :due_month=>"Jun" , :est_hours=>"15", :done=>"30 %")	
			
			end

def self.website_url
 OpenStruct.new(:url => "localhost:3000")
end
	
end
