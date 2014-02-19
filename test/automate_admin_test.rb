require 'ostruct'
require 'selenium-webdriver'
require 'test/unit'
require './data_admin'
 require './browser_helper'




class TestAutomateAdmin < Test::Unit::TestCase
	include BrowserHelper
	def data
		#website data
		@login_element= DataAdmin.login_elements
		@admin_data = DataAdmin.admin_data
		@website = DataAdmin.website_url
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
		p "Login into Redmine as admin"
		#home page, get sign in link
		element_click(@login_element.sign_in_link,'link')
    #login page
		value =@browser.page_source.include? "Register"
		assert_equal true,value
		
		fill_text(@login_element.username_id,@admin_data.username)
		fill_text(@login_element.password_id,@admin_data.password)
		p "Values Entered for Login"
	  element_click(@login_element.submit_id)
		p "Admin Logged in successfully"
		expected= @browser.page_source.include? ("admin")
		assert_equal expected, true
		assert_equal "Home\nLatest projects\nExample (02/13/2014 01:52 AM)", @browser.find_element(:id, "content").text
		assert_equal "http://localhost:3000/", @browser.current_url
    
	end
	
	
end
