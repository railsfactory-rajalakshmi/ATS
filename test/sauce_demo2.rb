#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'

caps = Selenium::WebDriver::Remote::Capabilities.iphone
caps.version = "5"
caps.platform = :XP
caps[:name] = "Testing Selenium 2 with Ruby on Sauce"

driver = Selenium::WebDriver.for(
  :remote,
  :url => "http://2006rajalakshmi:a5d6884f-55e9-4cba-83db-f3aea4727425@ondemand.saucelabs.com:80/wd/hub",
  :desired_capabilities => caps)
driver.navigate.to "http://www.google.com"
element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit
puts driver.title
driver.quit
