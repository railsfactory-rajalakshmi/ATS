require 'selenium-webdriver'
page_name="login"
File.exist?("./screen") ? FileUtils.rm_rf("./screen/.") : FileUtils.mkdir_p("./screen/")
i=1
path = "./screen"
@browser = Selenium::WebDriver.for(:chrome)  
@browser.get('http://inquirly2-new.railsfactory.com/')
@browser.save_screenshot("#{path}/" + page_name + i.to_s + ".png")
login=@browser.find_element(:class,"sign-in")
login.click
i=i+1
user=@browser.find_element(:id,"exampleInputEmail2")
user.send_keys("rajalakshmis@railsfactory.org")
pwd=@browser.find_element(:id,"exampleInputPassword2")
pwd.send_keys("sedin123")
submit=@browser.find_element(:class,"signin_submit")
@browser.save_screenshot("#{path}/" + page_name + i.to_s + ".png")
submit.click
i= i + 1
sleep 5
@browser.save_screenshot("#{path}/" + page_name + i.to_s + ".png")
sleep 2
arrow=@browser.find_element(:class,"arrow-down")
arrow.click
logout=@browser.find_element(:xpath,"/html/body/div/div/div[2]/div/a[2]")
logout.click
@browser.close