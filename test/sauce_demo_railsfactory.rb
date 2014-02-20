require "selenium-webdriver"
gem "test-unit"
require "test/unit"
require 'ostruct'

class TestSauceRailsfactory < Test::Unit::TestCase
	
	def data
		#define  diff browsers 
		@browser_capablity = OpenStruct.new( :browser=>"firefox", :platform=>"Windows", :version=>"27", :saucelabs_uname=>"2006rajalakshmi" ,:access_key=>"a5d6884f-55e9-4cba-83db-f3aea4727425" )
		#base url
		@website = OpenStruct.new(:url=> "http://www.railsfactory.com/")
		# to check assertion
		@page_title= OpenStruct.new(:index=>"Railsfactory - Index",:about_us =>"Railsfactory - About us",:services =>"Railsfactory - Services", :careers => "Railsfactory - Careers")
		@page_content = OpenStruct.new(:home=>"We are the Experts at",:about_us=>"History")
		@link_elements =OpenStruct.new(:about_us=>"About Us", :services => "Services" , :careers => "Careers")
	end
	
	def browser(browser)
	if browser == "firefox"
		Selenium::WebDriver::Remote::Capabilities.firefox
	elsif browser == "chrome"
		Selenium::WebDriver::Remote::Capabilities.chrome
	elsif browser == "internet_explorer"
		Selenium::WebDriver::Remote::Capabilities.internet_explorer
	elsif browser == "safari"
		Selenium::WebDriver::Remote::Capabilities.safari
	end
	end
	
 def setup
	data
	p @browser_capablity 
	caps = browser(@browser_capablity.browser)
	caps.platform = @browser_capablity.platform
	caps.version = @browser_capablity.version
  @driver = Selenium::WebDriver.for(
  :remote,
  :url => "http://" + @browser_capablity.saucelabs_uname + ":" + @browser_capablity.access_key + "@ondemand.saucelabs.com:80/wd/hub",
  :desired_capabilities => caps)
			#~ @driver =  Selenium::WebDriver.for(:firefox) 
    @base_url = @website.url
    @driver.manage.timeouts.implicit_wait = 30
  end
  
  def teardown
    @driver.quit
  end
  
  def test_sauce_railsfactory
    @driver.get(@base_url + "/")

    assert_equal @page_title.index, @driver.title
		p @page_content.home
    page_include(@page_content.home)
		
		@driver.find_element(:link, @link_elements.about_us).click
    assert_equal @page_title.about_us, @driver.title
		page_include(	@page_content.about_us)
		
    @driver.find_element(:link, @link_elements.services).click
		assert_equal @page_title.services, @driver.title
   
	 
    @driver.find_element(:link,  @link_elements.careers ).click
    assert_equal  @page_title.careers, @driver.title
  end
  

	
def page_include(content)
		value =@driver.page_source.include? content
		assert_equal true,value
end

	
end
