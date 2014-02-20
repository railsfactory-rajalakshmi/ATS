require 'ostruct'
require 'selenium-webdriver'
require 'test/unit'
require './data'
 require './browser_helper'




class TestAutomateUser < Test::Unit::TestCase
	include BrowserHelper
	def data
		#website data
		@login_ele = Data.login_elements
		@user = Data.user_data
		@website = Data.website_url
	end
	
	def setup
		data
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
		@browser.manage.timeouts.implicit_wait = 30
	end
	
	def teardown
    @browser.quit
  end
	
	def test_login
		p "Login into Redmine"
		#home page, get sign in link
		element_click(@login_ele.sign_in_link,'link')
    #login page
		value =@browser.page_source.include? "Register"
		assert_equal true,value
		fill_text(@login_ele.username_id,@user.username)
		fill_text(@login_ele.password_id,@user.password)
		p "Values Entered for Login"
	  element_click(@login_ele.submit_id)
		p "Logged in successfully"
		expected= @browser.page_source.include? ("rajalakshmi")
		assert_equal expected, true
		assert_equal "http://localhost:3000/", @browser.current_url
    
	end
	
	
end
