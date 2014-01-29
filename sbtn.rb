require 'selenium-webdriver'
require 'spreadsheet'
class Test

def initialize
@browser = Selenium::WebDriver.for(:firefox)  
end
def login(uname,pw)

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
button.click
end
def contact_us
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
 submit.click
end
#~ def close
#~ @browser.close  
#~ end
end

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open '/home/rajalakshmi/ATS/test.xls'
sheet1 = book.worksheet 0
sheet1.each do |row|
@uname =row[0]
p @uname
@pwd =row[1]
p @pwd
end
obj = Test.new
obj.login(@uname,@pwd)
obj.contact_us
#~ obj.close





