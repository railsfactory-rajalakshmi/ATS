 
 
 module BrowserHelper
 
 def fill_select(element,value,type='id')
		if type == 'id'
			Selenium::WebDriver::Support::Select.new(@browser.find_element(:id ,element)).select_by(:text, value)
		elsif type == 'class'
			Selenium::WebDriver::Support::Select.new(@browser.find_element(:class ,element)).select_by(:text, value)
		end
	end
	
	def fill_text(element,value)
		element_id=@wait.until{@browser.find_element(:id,element)}
		element_id.clear
		@wait.until{element_id.send_keys(value)}
	end
	
	def element_click(element,type='id')
			if type == 'link'
				@wait.until{  @browser.find_element(:link,element).click}
			elsif type == 'class'
				@wait.until{ @browser.find_element(:class,element).click}
			elsif type == 'id'
			  @wait.until{ @browser.find_element(:id,element).click}
			elsif type == 'name'
			@wait.until{ @browser.find_element(:name,element).click}
	 end
 end
 
 def element_present?(how, what)
   @browser.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

 
 
 end