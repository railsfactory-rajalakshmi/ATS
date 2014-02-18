require 'ostruct'
require 'selenium-webdriver'
require 'test/unit'
require './data'
 require './browser_helper'



class TestAutomateUser < Test::Unit::TestCase
		include BrowserHelper
	
	
	@dash_ele = ''
		def data
		#website data
		@login_ele = Data.login_elements
		@dash_ele= Data.dashboard_elements
		@myaccount_ele = Data.myaccounts_elements
		@project_ele=  Data.project_elements
		@user = Data.user_data
				@proj_data=  Data.project_data
				@website = Data.website_url
	end
	
	def setup
		data
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
		@browser.manage.timeouts.implicit_wait = 30
    @verification_errors = []
		
				tries = 0
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
	
	def teardown
    @browser.quit
    assert_equal [], @verification_errors
  end
	



	#Dashboard or home page after login
	def test_dashboard_page
		puts "test_dashboard_page"
		#tries = 0
		begin
		  element_click(@dash_ele.my_account_class,'class')
		rescue Exception => msg 
		#tries += 1
		#p msg
    #retry if tries <= 3
	  #p "element cannot be found in dash board"
	  end
	end
	
	def test_myaccount
				puts "test_myaccount"
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
		#tries += 1
    #retry if tries <= 3
	  #p "element cannot be found in my account"
	  end
	end
	
	def  test_project
						puts "test_project"
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
		#tries += 1
		#p msg
	  #retry if tries <= 3
    #	p "element cannot be found in project"
	  end
	end

	
	

end

