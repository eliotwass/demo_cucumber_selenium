book = Spreadsheet.open SharedVariables.xlspath
sheet1 = book.worksheet 1
user1 = sheet1.row(1)
user2 = sheet1.row(2)
browser = (ENV['browser'] || 'firefox').to_sym
driver = Selenium::WebDriver.for browser
 
puts "now testing in #{browser}" #this will indicate the brower being tested
#puts "#{SharedVariables.randomkey2} are your randomly generated test identifiers" #// when executing the script, this will identify the key used for creating a unique account name
#testIdHexKey = SecureRandom.hex(n=3) // uncomment to use SecureRandom.hex to generate 6 digits of random hex code
#puts driver.manage.window.size
confirm = ask("Proceed? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
exit unless confirm.downcase == 'y'
Given(/^I am on the salesforce login page$/) do
  target_size = Selenium::WebDriver::Dimension.new(1280, 800) 
  driver.manage.window.size = target_size
  puts "browser size is #{driver.manage.window.size}"
  puts 'navigating to salesforce login page'
  driver.get "https://na3.salesforce.com"
end

When(/^I enter my credentials$/) do
  driver.find_element(:id, "username").clear
  driver.find_element(:id, "username").send_keys SharedVariables.username
  driver.find_element(:id, "password").clear
  driver.find_element(:id, "password").send_keys SharedVariables.password
  driver.find_element(:id, "Login").click
  puts 'entering credentials and clicking login button'
end

Then(/^I expect to see the dashboard$/) do
  puts 'verifying landing page has loaded'
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:id, "phHeaderLogoImage") #wait until we see the header from the dashboard
    element if element.displayed?
  }
  puts "checking for element successful" if headerimage.displayed?
end

Then(/^I will access the create account page$/) do
  puts 'loading account tab'
  driver.find_element(:id, "Account_Tab").click #click the account tab
  @account_page_top_account = driver.find_element(:xpath,".//table[@class='list']//tr[2]//a").text()
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "createNewButton") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  puts 'checking for element successful'  if createnewbutton.displayed?
  driver.find_element(:id, "createNewButton").click #select the create new button"
  driver.find_element(:link, "Account").click #select 'account' create
  puts @account_page_top_account
  end

=begin
Then(/^I will enter required information and click save$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:name, "acc2")
    element if element.displayed?
  }
  puts 'entering some required and optional information, including a unique Account Name'
  driver.find_element(:id, "acc2").clear
  driver.find_element(:id, "acc2").send_keys user1[3]
  driver.find_element(:id, "acc23").clear
  driver.find_element(:id, "acc23").send_keys "http://testaccount.com"
  driver.find_element(:id, "acc17street").clear
  driver.find_element(:id, "acc17street").send_keys user1[8]
  driver.find_element(:id, "acc17city").clear
  driver.find_element(:id, "acc17city").send_keys user1[9]
  driver.find_element(:id, "acc17state").clear
  driver.find_element(:id, "acc17state").send_keys user1[6]
  driver.find_element(:id, "acc17zip").clear
  driver.find_element(:id, "acc17zip").send_keys "60606"
  driver.find_element(:id, "acc17country").clear
  driver.find_element(:id, "acc17country").send_keys "USA"
  driver.find_element(:id, "acc20").click
  driver.find_element(:id, "acc20").clear
  driver.find_element(:id, "acc20").send_keys "This describes the account being created"
  driver.find_element(:id, "acc10").clear
  driver.find_element(:id, "acc10").send_keys user1[4]
  dropDownMenu = driver.find_element(:id, 'acc6')
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, 'Financial Services')
  dropDownMenu = driver.find_element(:id, 'acc7')
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, 'Financial Services')
  driver.find_element(:css, "#bottomButtonRow > input[name=\"save\"]").click
end

Then(/^my first account is validated and a screenshot is captured$/) do
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:css, "h2.topName")
    element if element.displayed?
  }  
  element = driver.find_element(:id, "contactHeaderRow")
  element = driver.find_element(:id, "acc7_ileinner")
  element.text.should eql('Financial Services')
  driver.find_elements(:xpath, ".//*[contains(., user1[3]\)]").size >1
  puts 'Verifying information submitted successfully'
  time = Time.now.strftime('%a_%e_%Y_%l_%m_%p_%M')
  file_path = File.expand_path(File.dirname(__FILE__) + '/../../screenshots')+'/'+time +'.png'
  puts 'capturing a timestamped screenshot'
  driver.save_screenshot file_path
end

Then(/^I will delete the account$/) do
  if ENV['browser'] == 'phantomjs' or ENV['DRIVER'] == 
  driver.execute_script("window.confirm = function() {return true;}")
  driver.find_element(:name, "delete").click
  puts 'account deleted'
  else
  driver.find_element(:name, "delete").click
  driver.switch_to().alert().accept(); # change to alert().dismiss(); to keep the account
  puts 'account deleted'
end
end

Then(/^I will return to the create account page$/) do
  puts 'reloading loading account tab'
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "Account_Tab") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  driver.find_element(:id, "Account_Tab").click #click the account tab
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "createNewButton") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  puts 'checking for element successful'  if createnewbutton.displayed?
  driver.find_element(:id, "createNewButton").click #select the create new button
  driver.find_element(:link, "Account").click #select 'account' create
end

Then(/^I will enter required information for a second account and click save$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:name, "acc2")
    element if element.displayed?
  }
  puts 'entering some required and optional information, including a unique Account Name'
  driver.find_element(:id, "acc2").clear
  driver.find_element(:id, "acc2").send_keys user2[3]
  driver.find_element(:id, "acc23").clear
  driver.find_element(:id, "acc23").send_keys "http://testaccount2.com"
  driver.find_element(:id, "acc17street").clear
  driver.find_element(:id, "acc17street").send_keys user2[8]
  driver.find_element(:id, "acc17city").clear
  driver.find_element(:id, "acc17city").send_keys "Chicago"
  driver.find_element(:id, "acc17state").clear
  driver.find_element(:id, "acc17state").send_keys "IL"
  driver.find_element(:id, "acc17zip").clear
  driver.find_element(:id, "acc17zip").send_keys "60606"
  driver.find_element(:id, "acc17country").clear
  driver.find_element(:id, "acc17country").send_keys "USA"
  driver.find_element(:id, "acc20").click
  driver.find_element(:id, "acc20").clear
  driver.find_element(:id, "acc20").send_keys "This describes the account being created"
  driver.find_element(:id, "acc10").clear
  driver.find_element(:id, "acc10").send_keys "312-312-3121"
  dropDownMenu = driver.find_element(:id, 'acc7')
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, 'Business/Consumer Services')
  driver.find_element(:css, "#bottomButtonRow > input[name=\"save\"]").click
end

Then(/^my second account is validated and a screenshot is captured$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:css, "h2.topName")
    element if element.displayed?
  }
  element = driver.find_element(:id, "contactHeaderRow")
  element = driver.find_element(:id, "acc7_ileinner")
  element.text.should eql('Business/Consumer Services')
  driver.find_elements(:xpath, ".//*[contains(., '#{SharedVariables.randomkey2}'\)]").size >1
  puts 'Verifying information submitted successfully'
  time = Time.now.strftime('%a_%e_%Y_%l_%m_%p_%M')
  file_path = File.expand_path(File.dirname(__FILE__) + '/../../screenshots')+'/'+time +'.png'
  puts 'capturing a timestamped screenshot'
  driver.save_screenshot file_path
end

Then(/^I will delete the second account$/) do
  if ENV['browser'] == 'phantomjs' or ENV['DRIVER'] ==
  driver.execute_script("window.confirm = function() {return true;}")
  driver.find_element(:name, "delete").click
  puts 'account deleted'
  else
  driver.find_element(:name, "delete").click
  driver.switch_to().alert().accept();
  puts 'account deleted'
end
end

When(/^I reload the account page$/) do
  puts 'loading account tab'
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  accounttab = wait.until {
    element = driver.find_element(:id, "Account_Tab") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  puts 'checking for element successful'  if accounttab.displayed?
  driver.find_element(:id, "Account_Tab").click #click the account tab
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "createNewButton") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  puts 'checking for element successful'  if createnewbutton.displayed?
end

Then(/^neither accounts will display$/) do
  if driver.find_elements(:xpath, ".//*[contains(., '#{user1[3]}'\)]").size <1
    puts 'first created account not displayed'
  else
    puts 'first created account is displayed'
    driver.close()
    fail
  end
  if driver.find_elements(:xpath, ".//*[contains(., '#{SharedVariables.randomkey2}'\)]").size <1
    puts 'second created account not displayed'
  else
    puts 'second created account is displayed'
    driver.close()
    fail
  end
  end
=end


When(/^I create new accounts$/) do
    
  puts "beginning account create/delete cycle.  Information will be loaded from #{SharedVariables.xlspath}"
 sheet1.each 1 do |row|
    puts 'loading account tab'
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "Account_Tab") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  driver.find_element(:id, "Account_Tab").click #click the account tab
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  accounttable = wait.until {
    element = driver.find_element(:xpath,".//table[@class='list']//tr[2]//a") #wait until we see the button for creating a new entity
    element if element.displayed?
  }
  puts ' checking for element successful'  if accounttable.displayed?
  @account_page_top_account = driver.find_element(:xpath,".//table[@class='list']//tr[2]//a").text()
  puts "  The most recently accessed account is: #{@account_page_top_account}"
  driver.find_element(:id, "createNewButton").click #select the create new button
  driver.find_element(:link, "Account").click #select 'account' create
  wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  headerimage = wait.until {
    element = driver.find_element(:name, "acc2")
    element if element.displayed? 
      puts '   Create account screen has loaded'
  }
  puts "    entering test data for #{row[3]}"
  driver.find_element(:id, "acc2").clear
  driver.find_element(:id, "acc2").send_keys row[3]
  driver.find_element(:id, "acc23").clear
  driver.find_element(:id, "acc23").send_keys "http://testaccount.com"
  driver.find_element(:id, "acc17street").clear
  driver.find_element(:id, "acc17street").send_keys row[8]
  driver.find_element(:id, "acc17city").clear
  driver.find_element(:id, "acc17city").send_keys row[9]
  driver.find_element(:id, "acc17state").clear
  driver.find_element(:id, "acc17state").send_keys row[6]
  driver.find_element(:id, "acc17zip").clear
  driver.find_element(:id, "acc17zip").send_keys "60606"
  driver.find_element(:id, "acc17country").clear
  driver.find_element(:id, "acc17country").send_keys "USA"
  driver.find_element(:id, "acc20").click
  driver.find_element(:id, "acc20").clear
  driver.find_element(:id, "acc20").send_keys "This describes the account being created"
  driver.find_element(:id, "acc10").clear
  driver.find_element(:id, "acc10").send_keys row[4]
  dropDownMenu = driver.find_element(:xpath, ".//*[@id='00N50000001ut3O']")
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, row[7])
  dropDownMenu = driver.find_element(:id, 'acc6')
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, row[5])
  dropDownMenu = driver.find_element(:id, 'acc7')
  option = Selenium::WebDriver::Support::Select.new(dropDownMenu)
  option.select_by(:text, 'Financial Services')
  time = Time.now.strftime('%a_%e_%Y_%l_%m_%p_%s')
  file_path = File.expand_path(File.dirname(__FILE__) + '/../../screenshots')+'/'+time +'.png'
  puts '      capturing a timestamped screenshot'
  driver.save_screenshot file_path
  driver.find_element(:css, "#bottomButtonRow > input[name=\"save\"]").click
  error_message = driver.find_element(:xpath, "//div[@class='pbError']")
  if error_message.displayed?
  puts "        WARNING: entering test data for #{row[3]} failed, error has been displayed"
else puts '       account was saved'
  if ENV['browser'] == 'phantomjs' #or ENV['DRIVER'] ==
  driver.execute_script("window.confirm = function() {return true;}")
  sleep(2)
  driver.find_element(:name, "delete").click
  puts '        account deleted'
  else
  sleep(2)
  driver.find_element(:name, "delete").click
  driver.switch_to().alert().accept();
  puts '        account deleted'
end
end
  sleep 3
  driver.find_element(:xpath, "//input[@id='phSearchInput']").send_keys row[3]
  driver.find_element(:xpath, "//input[@id='phSearchButton']").click
  sleep 3
  #account_section = driver.find_element(:xpath, "//*[@id='Account']")
  if driver.find_elements(:xpath, "//div[@id='searchResultsWarningMessageBox']").size() > 0
    puts '         Search did not return your account in the list'
else 
  puts "         WARNING: account #{row[3]} was found during search!"

end
end
end
When(/^the accounts are deleted$/) do
  puts 'note: accounts should have been deleted immediately after they were created'
end

#Then(/^I will not see any of the accounts on the account page$/) do
#  if driver.find_elements(:xpath, ".//*[contains(., '#{sheet1}'\)]").size <1
#    puts 'first created account not displayed'
#  else
#    puts 'first created account is displayed'
#    driver.close()
#    fail
#  end
Then(/^I will not see any of the accounts on the account page or via search$/) do
driver.find_element(:id, "Account_Tab").click
driver.navigate.refresh
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  createnewbutton = wait.until {
    element = driver.find_element(:id, "bodyCell") #wait until we see the button for creating a new entity
    element if element.displayed? 
  }
 if driver.find_element(:xpath,".//table[@class='list']//tr[2]//a").text() == @account_page_top_account
  puts 'No changes present on accounts page'
else puts 'error: accounts page does not conform to pre-test conditions'
  driver.close()
  fail
end


#if driver.find_elements(:xpath, ".//*[contains(., '#{user1[3]}'\)]").size <1
#    puts 'first created account not displayed'
#  else
#    puts 'first created account is displayed'
#    driver.close()
#    fail
#  end
#  if driver.find_elements(:xpath, ".//*[contains(., '#{SharedVariables.randomkey2}'\)]").size <1
#    puts 'second created account not displayed'
#  else
#    puts 'second created account is displayed'
#    driver.close()
#    fail
#  end
#end
at_exit do
  driver.close()
end
end

