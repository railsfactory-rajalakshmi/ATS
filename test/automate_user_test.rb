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

	
	
	
end
