require 'ostruct'
require 'selenium-webdriver'
require 'test/unit'
class AutomateUser < Test::Unit::TestCase
	@dash_ele = ''
	def data
		#website data
		@login_ele = OpenStruct.new(:sign_in_link=>"Sign in",:username_id=>"username",:password_id=>"password",:submit_id=>"login_submit_id")
		@dash_ele= OpenStruct.new(:my_account_class =>"my-account")
		@myaccount_ele = OpenStruct.new(:fname_id =>"user_firstname", :lname_id =>"user_lastname",:mail_id =>"user_mail", :lang_id=>"user_language", :mail_notification_id=>"user_mail_notification", :pref_notified_id=>"pref_no_self_notified", :pref_mail=>"pref_hide_mail",:zone=>"pref_time_zone",:sorting=>"pref_comments_sorting",:unsaved=>"pref_warn_on_leaving_unsaved", :acct_id=>"myaccount_id")
		#project elemnet id,class, links
		@project_ele= OpenStruct.new(:link=>"Projects",:id=>"project_id1",:bug_link=>"Bug",:new_issue =>"New issue",:itracker_id=>"issue_tracker_id",:subject_id=>"issue_subject",:description_id => "issue_description",:bold_class=>"jstb_strong",:status_id=>"issue_status_id",:priority_id=>"issue_priority_id",:assign_id=>"issue_assigned_to_id",:date_img=>"ui-datepicker-trigger",:date_css=>"img.ui-datepicker-trigger",:date=>"14",:year_cl=>"ui-datepicker-year",:dpick_image=>"#due_date_area > img.ui-datepicker-trigger", :month_css	=>"ui-datepicker-month",:est_hours=>"issue_estimated_hours",:done_id=>"issue_done_ratio",:submit=>"commit")
		@website = OpenStruct.new(:url => "localhost:3000")
		#user data
		@user = OpenStruct.new(:username => "rajalakshmi", :password=>"123456789", :firstname=>'Rajalakshmi', :lastname=>'Shanmugam',:mail=>'rajalakshmi@railsfactory.com', :language=>'English', :mail_notification=>"No events",:pref_time_zone=>"(GMT-10:00) Hawaii",:pref_comments_sorting=>"In reverse chronological order")
		@proj_data=OpenStruct.new(:tracker => "Feature",:subject=>"IE error",:desc=>"IE error description",:status=>"In Progress"	, :priority =>"Urgent", :assigne=>"Rajalakshmi Shanmugam", :start_year=>"2012" , :start_month =>"May", :date=>"5", :due_year =>"2014", :due_month=>"Jun" , :est_hours=>"15", :done=>"30 %")
	end
	
	def setup
		data
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
		@browser.manage.timeouts.implicit_wait = 30
    @verification_errors = []
	end
	
	def teardown
    @browser.quit
    assert_equal [], @verification_errors
  end
	
	def test_login
		tries = 0
		data
		begin
		#home page, get sign in link
		element_click(@login_ele.sign_in_link,'link')
    #login page
		fill_text(@login_ele.username_id,@user.username)
		fill_text(@login_ele.password_id,@user.password)
	  element_click(@login_ele.submit_id)
		rescue Exception => msg 
		tries += 1
		p msg
    retry if tries <= 3
	  p "element cannot be found in login page"
	  end
	end
	
	#Dashboard or home page after login
	def test_dashboard_page
		tries = 0
		begin
		  element_click(@dash_ele.my_account_class,'class')
		rescue Exception => msg 
		tries += 1
		p msg
    retry if tries <= 3
	  p "element cannot be found in dash board"
	  end
	end
	
	def test_myaccount
			tries = 0
		
		begin
		fill_text(@myaccount_ele.fname_id,@user.firstname)
		fill_text(@myaccount_ele.lname_id,@user.lastname)
		fill_text(@myaccount_ele.mail_id,@user.mail)
		fill_select(@myaccount_ele.lang_id,@user.language)
		fill_select(@myaccount_ele.mail_notification_id,@user.mail_notification)
		element_click(@myaccount_ele.pref_notified_id)
		element_click(@myaccount_ele.pref_mail)
		fill_select(@myaccount_ele.zone,@user.pref_time_zone)
		fill_select(@myaccount_ele.sorting,@user.pref_comments_sorting)
		element_click(@myaccount_ele.unsaved)
	  element_click(@myaccount_ele.acct_id)
		rescue
		tries += 1
    retry if tries <= 3
	  p "element cannot be found in my account"
	  end
	end
	
	def  test_project
		tries = 0
		
		begin
		element_click(@project_ele.link,'link')
		element_click(@project_ele.id)
		element_click(@project_ele.bug_link,'link')
		element_click(@project_ele.new_issue,'link')
	  fill_select(@project_ele.itracker_id,@proj_data.tracker)
		sleep 2
	  fill_text(@project_ele.subject_id,@proj_data.subject)
		bold =@browser.find_element(:class,@project_ele.bold_class).click
		fill_text(@project_ele.description_id,@proj_data.desc)
		fill_select(@project_ele.status_id,@proj_data.status)
		fill_select(@project_ele.priority_id,@proj_data.priority)
		fill_select(@project_ele.assign_id,@proj_data.assigne)
		@browser.find_elements(:class, @project_ele.date_img)[0].click
		fill_select(@project_ele.year_cl,@proj_data.start_year,'class')
		fill_select(@project_ele.month_css,@proj_data.start_month,'class')
		element_click(@proj_data.date,'link')
		@browser.find_elements(:class, @project_ele.date_img)[1].click
		fill_select(@project_ele.year_cl,@proj_data.due_year,'class')
		fill_select(@project_ele.month_css,@proj_data.due_month,'class')
    element_click(@project_ele.date,'link')
		fill_text(@project_ele.est_hours,@proj_data.est_hours)
		fill_select(@project_ele.done_id, @proj_data.done)
		element_click(@project_ele.submit,'name')
    rescue Exception => msg 
		tries += 1
		p msg
	  retry if tries <= 3
    	p "element cannot be found in project"
	  end
	end
	
	
	def fill_select(element,value,type='id')
		if type == 'id'
			Selenium::WebDriver::Support::Select.new(@browser.find_element(:id ,element)).select_by(:text, value)
		elsif type == 'class'
			Selenium::WebDriver::Support::Select.new(@browser.find_element(:class ,element)).select_by(:text, value)
		end
	end
	
	def fill_text(element,value)
		element_id=@browser.find_element(:id,element)
		element_id.clear
		element_id.send_keys(value)
	end
	
	def element_click(element,type='id')
			if type == 'link'
				@wait.until{  @browser.find_element(:link,element).click}
			elsif type == 'class'
				@wait.until{ @browser.find_element(:class,element).click}
			elsif type == 'id'
			  @wait.until{ @browser.find_element(:id,element).click}
			elsif type == 'name'
			@wait.until{ @browser.find_element(:name,element).click}
	 end
	end
	

end
obj=AutomateUser.new
obj.data
obj.setup
obj.test_login
obj.test_dashboard_page
obj.test_myaccount
obj.test_project