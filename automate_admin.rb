require 'ostruct'
require 'selenium-webdriver'

class AutomateAdmin
	
	def data
		#website data
		@website = OpenStruct.new(:url => "localhost:3000")
		#user data
		@user = OpenStruct.new(:username => "admin", :password=>"admin", :firstname=>'Redmine', :lastname=>'Admin',:mail=>'admin@example.net',:language=>'(auto)', :mail_notification=>"For any event on all my projects",:pref_time_zone=>"(GMT-10:00) Hawaii",:pref_comments_sorting=>"In reverse chronological order")
		end
	def setup
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
	end
	
	def login_page
		#home page, get sign in link
    @browser.find_element(:link, "Sign in").click
		#login page
		@browser.find_element(:id, "username").send_keys(@user.username)
		@browser.find_element(:id, "password").send_keys(@user.password)
		@browser.find_element(:id,"login_submit_id").click
	end
	
	#Dashboard or home page after login
	def dashboard_page
		@wait.until{@browser.find_element(:class, "my-account").click}
		@wait.until{@browser.find_element(:class, "my-account").displayed? }
	end
	
	def myaccount
		firstname=@browser.find_element(:id,"user_firstname")
		firstname.clear
		firstname.send_keys(@user.firstname)
		lastname=@browser.find_element(:id,"user_lastname")
		lastname.clear
		lastname.send_keys(@user.lastname)
		email=	@browser.find_element(:id,"user_mail")
		email.clear
		email.send_keys(@user.mail)
		@user.language
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id, "user_language")).select_by(:text,@user.language)
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id, "user_mail_notification")).select_by(:text,@user.mail_notification)
		@browser.find_element(:id,"pref_no_self_notified").click
		@browser.find_element(:id,"pref_hide_mail").click
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,"pref_time_zone")).select_by(:text,@user.pref_time_zone)
	  Selenium::WebDriver::Support::Select.new(@browser.find_element(:id,"pref_comments_sorting")).select_by(:text,@user.pref_comments_sorting)
		@browser.find_element(:id,"pref_warn_on_leaving_unsaved").click
		@browser.find_element(:id,"myaccount_id").click
	end

end
test=AutomateAdmin.new
test.data
test.setup
test.login_page
test.dashboard_page
test.myaccount