require 'ostruct'
require 'selenium-webdriver'

class AutomateUser
	
	def data
		#website data
		@login_ele = OpenStruct.new(:sign_in_link=>"Sign in",:username_id=>"username",:password_id=>"password",:submit_id=>"login_submit_id")
		@dash_ele= OpenStruct.new(:my_account_class =>"my-account")
		@myaccount_ele = OpenStruct.new(:fname_id =>"user_firstname", :lname_id =>"user_lastname",:mail_id =>"user_mail", :language_id=>"user_language", :mail_notification_id=>"user_mail_notification", :pref_notified_id=>"pref_no_self_notified", :pref_mail=>"pref_hide_mail",:zone=>"pref_time_zone",:sorting=>"pref_comments_sorting",:unsaved=>"pref_warn_on_leaving_unsaved", :acct_id=>"myaccount_id")
		
		#project elemnet id,class, links
		@project_ele= OpenStruct.new(:link=>"Projects",:id=>"project_id1",:bug_link=>"Bug",:new_issue =>"New issue",:itracker_id=>"issue_tracker_id",:subject_id=>"issue_subject",:description_id => "issue_description",:bold_class=>"jstb_strong",:status_id=>"issue_status_id",:priority_id=>"issue_priority_id",:assign_id=>"issue_assigned_to_id",:date_css=>"img.ui-datepicker-trigger",:date=>"14",:year_cl=>"ui-datepicker-year",:dpick_image=>"#due_date_area > img.ui-datepicker-trigger", :month_css	=>"ui-datepicker-month",:est_hours=>"issue_estimated_hours",:done_id=>"issue_done_ratio",:submit=>"commit")
		@website = OpenStruct.new(:url => "localhost:3000")
		
		#user data
		@user = OpenStruct.new(:username => "rajalakshmi", :password=>"123456789", :firstname=>'Rajalakshmi', :lastname=>'Shanmugam',:mail=>'rajalakshmi@railsfactory.com', :language=>'English', :mail_notification=>"No events",:pref_time_zone=>"(GMT-10:00) Hawaii",:pref_comments_sorting=>"In reverse chronological order")
		
	@proj_data=OpenStruct.new(:tracker => "Feature", :status=>"In Progress"	, :priority =>"Urgent", :assigne=>"Rajalakshmi Shanmugam", :start_year=>"2012" , :start_month =>"May", :date=>"5", :due_year =>"2014", :due_month=>"Jun" , :est_hours=>"15", :done=>"30 %")
		end
	def setup
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
	end
	
	def login_page
		#home page, get sign in link
    @browser.find_element(:link,@login_ele.sign_in_link).click
		@wait.until{ @browser.find_element(:link,@login_ele.sign_in_link).displayed? }
    #login page
		@browser.find_element(:id, @login_ele.username_id).send_keys(@user.username)
		@browser.find_element(:id, @login_ele.password_id).send_keys(@user.password)
		@browser.find_element(:id,@login_ele.submit_id).click
	end
	
	#Dashboard or home page after login
	def dashboard_page
		@wait.until{@browser.find_element(:class,@dash_ele.my_account_class).click}
		@wait.until{@browser.find_element(:class, @dash_ele.my_account_class).displayed? }
	end
	
	def myaccount
		firstname=@browser.find_element(:id,@myaccount_ele.fname_id)
		firstname.clear
		firstname.send_keys(@user.firstname)
		lastname=@browser.find_element(:id,@myaccount_ele.lname_id)
		lastname.clear
		lastname.send_keys(@user.lastname)
		email=	@browser.find_element(:id,@myaccount_ele.mail_id)
		email.clear
		email.send_keys(@user.mail)
		@user.language
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@myaccount_ele.language_id)).select_by(:text,@user.language)
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id, @myaccount_ele.mail_notification_id)).select_by(:text,@user.mail_notification)
		@browser.find_element(:id,@myaccount_ele.pref_notified_id).click
		@browser.find_element(:id,@myaccount_ele.pref_mail).click
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@myaccount_ele.zone)).select_by(:text,@user.pref_time_zone)
	  Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@myaccount_ele.sorting)).select_by(:text,@user.pref_comments_sorting)
		@browser.find_element(:id,@myaccount_ele.unsaved).click
		@wait.until{@browser.find_element(:id,@myaccount_ele.acct_id).click}
	end
	
	def  project
		
		@browser.find_element(:link,@project_ele.link).click
		@wait.until{@browser.find_element(:id,@project_ele.id).displayed? }
		@wait.until{@browser.find_element(:id,@project_ele.id).click}
		@wait.until{@browser.find_element(:link,@project_ele.bug_link).displayed? }
		@browser.find_element(:link,@project_ele.bug_link).click
	  @wait.until{@browser.find_element(:link,@project_ele.new_issue).click}
		@wait.until{@browser.find_element(:id,@project_ele.itracker_id).displayed?}
	  Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@project_ele.itracker_id)).select_by(:text,@proj_data.tracker)
		sleep 2
	  subject=@browser.find_element(:id,@project_ele.subject_id)
		@wait.until{subject.displayed?}
		subject.clear
		subject.send_keys("IE error")
		desc=@browser.find_element(:id,@project_ele.description_id)
		desc.clear
		desc.send_keys("IE error description")
		bold =@browser.find_element(:class,@project_ele.bold_class).click
		desc.send_keys("FOUND IN LINE 2")
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@project_ele.status_id)).select_by(:text, @proj_data.status)}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@project_ele.priority_id)).select_by(:text,@proj_data.priority)	}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,@project_ele.assign_id)).select_by(:text,@proj_data.assigne)	}
		@wait.until{@browser.find_elements(:class, "ui-datepicker-trigger")[0].click}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:class, @project_ele.year_cl)).select_by(:text, @proj_data.start_year)}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:class, @project_ele.month_css)).select_by(:text,  @proj_data.start_month)}
		@wait.until{@browser.find_element(:link, @proj_data.date).click}
		@wait.until{@browser.find_elements(:class, "ui-datepicker-trigger")[1].click}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:class, @project_ele.year_cl)).select_by(:text, @proj_data.due_year)}
		@wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:class, @project_ele.month_css)).select_by(:text, @proj_data.due_month)}
		@wait.until{@browser.find_element(:link, @project_ele.date).click}
    @wait.until{@browser.find_element(:id, @project_ele.est_hours).send_keys(@proj_data.est_hours)}
    @wait.until{Selenium::WebDriver::Support::Select.new(@browser.find_element(:id, @project_ele.done_id)).select_by(:text, @proj_data.done)}
    @wait.until{@browser.find_element(:name, @project_ele.submit).click}
	end
	
	

	
	

end
test=AutomateUser.new
test.data
test.setup
test.login_page
test.dashboard_page
test.myaccount
test.project