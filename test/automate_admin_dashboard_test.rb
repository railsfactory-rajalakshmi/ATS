require 'ostruct'
require 'selenium-webdriver'
require 'test/unit'
require './data_admin'
require './browser_helper'


class TestAutomateAdminDashboard < Test::Unit::TestCase
	include BrowserHelper
	def data
		#website data
		@login_element= DataAdmin.login_elements
		@admin_link_elements=DataAdmin.adminstration_elements
		@admin_project_elements= DataAdmin.admin_project_elements
		@admin_data = DataAdmin.admin_data
		@website = DataAdmin.website_url
		@admin_project_status = DataAdmin.admin_project_status
		@admin_project_data = DataAdmin.admin_project_data
	end
	
	def setup
		data
		@wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
		@browser =  Selenium::WebDriver.for(:firefox) 
		@browser.get(@website.url)		
		@browser.manage.timeouts.implicit_wait = 30
		#home page, get sign in link
		element_click(@login_element.sign_in_link,'link')
    #login page
		fill_text(@login_element.username_id,@admin_data.username)
		fill_text(@login_element.password_id,@admin_data.password)
	  element_click(@login_element.submit_id)
		puts "Logged in successfully"
	
	end
	
	def teardown
    @browser.quit
	end
	

	def test_adminstration
		puts "Adminstration link "
		p "Logged in as admin"
		element_click(@admin_link_elements.link,'link')
		p "Adminstration link"
		get_url = @browser.current_url
		p "verify adminstration link if true through url"
		assert_equal("http://localhost:3000/admin",get_url)
		@browser.find_elements(:class,@admin_link_elements.project_link)[1].click
		fill_select(@admin_link_elements.status_id,@admin_project_status.status)
		element_click(@admin_link_elements.apply,'class')
		p "Check for the status and check if the project is displayed"
		assert element_present?(:link , "Archive")
		assert element_present?(:link , "Copy")
		assert element_present?(:link , "Delete")
		p "Create a new project"
		element_click(@admin_link_elements.new_project,'link')
	  get_url = @browser.current_url
		assert_equal("http://localhost:3000/projects/new",get_url)
		#fill the form in new project
		fill_text(@admin_project_elements.project_name,@admin_project_data.project_name)
		assert_equal "", @browser.find_element(:id, @admin_project_elements.project_name).text
		fill_text(@admin_project_elements.project_description,@admin_project_data.project_description)
	  fill_text(@admin_project_elements.project_identifier,@admin_project_data.project_identifier)
	  fill_text(@admin_project_elements.project_homepage,@admin_project_data.project_homepage)
		element_click(@admin_project_elements.submit_name,'name')
	
	end
	
	
end
