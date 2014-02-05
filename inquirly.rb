require 'selenium-webdriver'
require 'roo'
require 'open-uri'
require 'nokogiri'

class Inquirly

def initialize
@page_name="login"
File.exist?("./screen") ? FileUtils.rm_rf("./screen/.") : FileUtils.mkdir_p("./screen/")
@i=1
@path = "./screen"
@browser = Selenium::WebDriver.for(:chrome) 
@doc = Nokogiri::HTML(open( "http://inquirly2-new.railsfactory.com/"))
end
def get_url(url)
@browser.get(url)
@browser.save_screenshot("#{@path}/" + @page_name + @i.to_s + ".png")
end
def get_link
anchor = @doc.css('a')
anchor.each{|href| puts href[:id]}

end

def login_page(user,pwd)
login=@browser.find_element(:class,"sign-in")
login.click
@i=@i+1
username=@browser.find_element(:id,"exampleInputEmail2")
username.send_keys(user)
password=@browser.find_element(:id,"exampleInputPassword2")
password.send_keys(pwd)
submit=@browser.find_element(:class,"signin_submit")
@browser.save_screenshot("#{@path}/" + @page_name + @i.to_s + ".png")
submit.click
@i= @i + 1
sleep 5
@browser.save_screenshot("#{@path}/" + @page_name + @i.to_s + ".png")
sleep 2
arrow=@browser.find_element(:class,"arrow-down")
arrow.click
end
def logout
logout=@browser.find_element(:xpath,"/html/body/div/div/div[2]/div/a[2]")
logout.click
end
def close_browser
@browser.close
end
end

oo = Roo::Excel.new("value.xls")
oo.default_sheet = oo.sheets.first
url =oo.cell(1,1)
user = oo.cell(2,1)
pwd=oo.cell(3,1)
obj=Inquirly.new
obj.get_url(url)
obj.login_page(user,pwd)
obj.logout
obj.close_browser

