=begin
30.01.2014
Today I have tried with roo gem since It could work with google doc,excel and also in ods files,
Also I have take screen shots of the files, I have run the code for sbtn browser with chrome browser
=end
require 'ostruct'
require 'selenium-webdriver'
require 'roo'
require 'open-uri'
require 'nokogiri'

class Test

File.exist?("./tmp") ? FileUtils.rm_rf("./tmp/.") : FileUtils.mkdir_p("./tmp/")
$temp_path = "./tmp"
def initialize
 @browser = Selenium::WebDriver.for(:chrome)  
 @doc = Nokogiri::HTML(open("http://localhost:3000/contacts/new"))
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

def contact_us(page_name,contact)
 a=[]
 input_id = @doc.css('input')
 text_area =@doc.css('textarea')
  text_area.each { |ta| 
 p "ID OF TEXTAREA =" + ta[:id] 
 }
 input_id.each { |t| 
 a << t[:id]
 }
 len=a.length
 i=0
 for i in 0..len
  if(a[i] != nil )
   p a[i]
  end
 end
 p a.length

 contact_link= @browser.find_element(:xpath,"/html/body/div/ul/li[2]/a")
 contact_link.click
 cname=@browser.find_element(:id,a[2])
 cname.send_keys(contact.name)
 contact_company_name=@browser.find_element(:id,a[3])
 contact_company_name.send_keys(contact.company_name)
 contact_email= @browser.find_element(:id,a[4])
 contact_email.send_keys(contact.email)
 contact_mobile_number=@browser.find_element(:id,a[5])
 contact_mobile_number.send_keys(contact.mobile_number)
 contact_subject=@browser.find_element(:id,a[6])
 contact_subject.send_keys(contact.subject)
 contact_description=@browser.find_element(:id,'contact_description')
 contact_description.send_keys(contact.description)
 submit =@browser.find_element(:id , a[7])
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
@contact = OpenStruct.new
@contact.name='Test'
@contact.company_name='Test company'
@contact.email='Test@gmail.com'
@contact.mobile_number='987654321'
@contact.subject='Test subject'
@contact.description='Test Description for sbtn app'
obj.contact_us("contact",@contact)






