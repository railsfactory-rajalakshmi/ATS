require 'selenium-webdriver'
require 'roo'
require 'open-uri'
require 'nokogiri'

class Inquirly

def initialize
	File.exist?("./screen") ? FileUtils.rm_rf("./screen/.") : FileUtils.mkdir_p("./screen/")
	@path = "./screen"
	#will either work with chrome or firefox which ever driver is available
	@browser = Selenium::WebDriver.for(:chrome) || Selenium::WebDriver.for(:firefox) 
	@doc = Nokogiri::HTML(open( "http://inquirly2-new.railsfactory.com/"))
end

def get_url(page_name,url)
	 begin
	#go to that particular url
    @browser.get(url)
	#to save the screen shot
	  @browser.save_screenshot("#{@path}/" + page_name + ".png")
	 rescue Selenium::WebDriver::Error::TimeOutError
    exit(1)
   end
 end

def get_link
	#to get all link in a html page
	@a=[]
	i=0
	anchor = @doc.css('a')
	p 'links available in this page is '
	anchor.each{|href| 
	puts href
	}
	p "input elements ids available are"
	input_id=@doc.css('input')
	input_id.each { |t| 
 @a << t[:id]
 }
 for i in 0..@a.length
 if(@a[i] != nil )
	p @a[i] 
 end
 end
end

#to fill the login details
def login_page(page_name,user,pwd)
	begin
		i=1
		login=@browser.find_element(:class,"sign-in")
		login.click
		username=@browser.find_element(:id,@a[2])
		username.send_keys(user)
		password=@browser.find_element(:id,@a[3])
		password.send_keys(pwd)
		submit=@browser.find_element(:class,"signin_submit")
		@browser.save_screenshot("#{@path}/" + page_name + i.to_s + ".png")
		submit.click
		i= i + 1
		sleep 5
		@browser.save_screenshot("#{@path}/" + page_name + i.to_s + ".png")
		sleep 2
		arrow=@browser.find_element(:class,"arrow-down")
		arrow.click
	rescue Selenium::WebDriver::Error::TimeOutError
	  exit(1)
  end
end
	#logout the page 
def logout(page_name)
	logout=@browser.find_element(:xpath,"/html/body/div/div/div[2]/div/a[2]")
	logout.click
end

def close_browser
 @browser.close
end
end
#I have included url, user, password in value.xls file
oo = Roo::Excel.new("value.xls")
oo.default_sheet = oo.sheets.first
#to fetch the values from the xls file
url =oo.cell(1,2)
user = oo.cell(2,2)
pwd=oo.cell(3,2)
obj=Inquirly.new
obj.get_link
obj.get_url('url',url)
obj.login_page('login',user,pwd)
obj.logout('logout')
obj.close_browser

