require "selenium-webdriver"
gem "test-unit"
require "test/unit"
require "./browser_capablities"
require 'ostruct'

class TestSauceRailsfactory < Test::Unit::TestCase
	
	
		def data
			p "data"
		#define  diff browsers 
		@browser_capablity = OpenStruct.new( :browser=>"firefox", :platform=>"Windows", :version=>"27", :saucelabs_uname=>"2006rajalakshmi" ,:access_key=>"a5d6884f-55e9-4cba-83db-f3aea4727425" )
		#base url
		@website = OpenStruct.new(:url=> "http://www.railsfactory.com/")
		# to check assertion
		@page_title= OpenStruct.new(:index=>"Railsfactory - Index",:about_us =>"Railsfactory - About us",:services =>"Railsfactory - Services", :careers => "Railsfactory - Careers")
		@page_content = OpenStruct.new(:home=>"We are the Experts at",:about_us=>"History")
		@link_elements =OpenStruct.new(:about_us=>"About Us", :services => "Services" , :careers => "Careers")
	end
	
def setup
	data
	p "set up"
	File.exist?("./tmp") ? FileUtils.rm_rf("./tmp/.") : FileUtils.mkdir_p("./tmp/")
	@temp_path = "./tmp"
	puts "please enter the no fo browser you want to run the code "
	no_of_browser = gets.chomp.to_i
	
	caps = []
	browser=[]
	platform=[]
	version=[]
	for i in 1..no_of_browser
	puts "Please enter the browser u want to run the test"
  browser[i] =gets.chomp
	if(browser[i]=='internet_explorer')
	puts "please choose which windows platform you want to run the test('Windows 8 / Windows 8.1 / Windows 7 / Windows XP)"
	platform= gets.chomp
	else
	puts "Please enter the platform u want to run the test"
	platform[i] =gets.chomp
	end
	puts "Please enter the version of the browser u want to run the test"
	version[i] = gets.chomp
	caps[i] = browser(browser[i])
	caps[i].platform = platform[i]
	caps[i].version = version[i]
end
p caps = caps.compact
p caps.length
for i in 0..caps.length 
t1= Thread.new {driver(caps[i])}
t2= Thread.new {driver(caps[i+1])}
t1.join
 t2.join
end
#~ end
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


  
  def teardown
    @driver.quit
  end
  
  def test_sauce_railsfactory
		p 44444444
    @driver.get(@base_url + "/")
		screenshots(@page_title.index)
    assert_equal @page_title.index, @driver.title
		p 555555555555
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
  
def driver(caps)
	 p @driver = Selenium::WebDriver.for(
  :remote,
  :url => "http://" + @browser_capablity.saucelabs_uname + ":" + @browser_capablity.access_key + "@ondemand.saucelabs.com:80/wd/hub",
  :desired_capabilities => caps)
			#~ @driver =  Selenium::WebDriver.for(:firefox) 
    @base_url = @website.url
		p 22222222
    @driver.manage.timeouts.implicit_wait = 30
		p 333333333333
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
	
def page_include(content)
		value =@driver.page_source.include? content
		assert_equal true,value
end

def screenshots(page)
	@driver.save_screenshot("#{@temp_path}/" + page + ".png")
end
	
end
