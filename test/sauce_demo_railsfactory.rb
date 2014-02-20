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
	File.exist?("./tmp") ? FileUtils.rm_rf("./tmp/.") : FileUtils.mkdir_p("./tmp/")
	@temp_path = "./tmp"
	p @browser_capablity 
	puts "Please enter the browser u want to run the test"
  browser =gets.chomp
	if(browser=='internet_explorer')
		puts "please choose which windows platform you want to run the test('Windows 8 / Windows 8.1 / Windows 7 / Windows XP)"
		platform= gets.chomp
	else
	puts "Please enter the platform u want to run the test"
	platform =gets.chomp
	end
	puts "Please enter the version of the browser u want to run the test"
	version = gets.chomp
	caps = browser(browser)
	caps.platform = platform
	caps.version = version
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
		screenshots(@page_title.index)
    assert_equal @page_title.index, @driver.title
		
		 page_include(@page_content.home)
		screenshots(@page_title.about_us)
		
		@driver.find_element(:link, @link_elements.about_us).click
    assert_equal @page_title.about_us, @driver.title
		page_include(	@page_content.about_us)
		screenshots(@page_title.about_us+"1")
		
    @driver.find_element(:link, @link_elements.services).click
		assert_equal @page_title.services, @driver.title
   		screenshots(@page_title.services)
	 
    @driver.find_element(:link,  @link_elements.careers ).click
    assert_equal  @page_title.careers, @driver.title
		screenshots(@page_title.careers)
  end
  

	
def page_include(content)
		value =@driver.page_source.include? content
		assert_equal true,value
end

def screenshots(page)
	@driver.save_screenshot("#{@temp_path}/" + page + ".png")
end
	
end
