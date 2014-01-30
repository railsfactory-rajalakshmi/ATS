= begin
30.01.2014
Today I have tried with roo gem since It could work with google doc,excel and also in ods files,
Also I have take screen shots of the files, I have run the code for sbtn browser with chrome browser
=end

require 'selenium-webdriver'
require 'roo'
class Test

File.exist?("./tmp") ? FileUtils.rm_rf("./tmp/.") : FileUtils.mkdir_p("./tmp/")
$temp_path = "./tmp"
def initialize
 @browser = Selenium::WebDriver.for(:chrome)  
end

def login(uname,pw, page_name)

#url trigger
@browser.get('http://localhost:3000/')
#to wait for 10sec
wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
#login form 
login=@browser.find_element(:xpath,"/html/body/div/p/a[2]")
login.click
user = @browser.find_element(:id, 'user_email')
user.send_keys(uname)
pwd = @browser.find_element(:id, 'user_password')
pwd.send_keys(pw)
button = @browser.find_element(:id , 'user_submit')
@browser.save_screenshot("#{$temp_path}/" + page_name + ".png")
button.click
end

def contact_us(page_name)
 contact= @browser.find_element(:xpath,"/html/body/div/ul/li[2]/a")
 contact.click
 name=@browser.find_element(:id,"contact_name")
 name.send_keys('Test')
 contact_company_name=@browser.find_element(:id,"contact_company_name")
 contact_company_name.send_keys('Test')
 contact_email= @browser.find_element(:id,"contact_email")
 contact_email.send_keys('Test@gmail.com')
 contact_mobile_number=@browser.find_element(:id,"contact_mobile_number")
 contact_mobile_number.send_keys('987654321')
 contact_subject=@browser.find_element(:id,"contact_subject")
 contact_subject.send_keys('Test')
 contact_description=@browser.find_element(:id,"contact_description")
 contact_description.send_keys('This is a test for ats')
 submit =@browser.find_element(:id , "contact_submit")
@browser.save_screenshot("#{$temp_path}/" + page_name + ".png")
 submit.click
end
#~ def close
#~ @browser.close  
#~ end
end


oo = Roo::Excel.new("test.xls")
oo.default_sheet = oo.sheets.first
@uname =oo.cell(1,1)
@pwd = oo.cell(2,1).to_i
obj = Test.new
obj.login(@uname,@pwd, "login")
obj.contact_us("contact")






