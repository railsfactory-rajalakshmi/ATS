require "selenium/client"
require "selenium-webdriver"
require "rubygems"
require 'roo'

class Sample
	def initialize(url)
		@browser = Selenium::WebDriver.for(:firefox) 
		@browser.manage().window.maximize();
		@browser.get(url)
	end
		
	def click_link(link_id)
		@browser.find_element(:id,link_id).click
	end
	def click_button(button_id)
	  @browser.find_element(:id,button_id).click 
	end
	def textbox(txt_id,txt_value)
  	@browser.find_element(:id,txt_id).send_keys(txt_value) 
	end
	def email(email_id,email_value)
		@browser.find_element(:id,email_id).send_keys(email_value) 
	end
	def closebrowser
		@browser.close
	end
	def dropdown(id,value)
		Selenium::WebDriver::Support::Select.new(@browser.find_element(:id, id)).select_by(:text, value)
	end

	def radiobuttoncheck(id,value)
		@browser.find_element(:id=> id, :value => value).click
  end
	def password(pwd_id,pwd_value)
		@browser.find_element(:id,pwd_id).send_keys(pwd_value)
	end
	
	end
			
 