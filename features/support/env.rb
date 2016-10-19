require 'selenium-webdriver'
require 'securerandom'
require 'rspec'
require 'page-object'
require 'spreadsheet'
require 'highline/import'
require 'cucumber'

#// when executing the script, this will identify the key used for creating a unique account name
#testIdHexKey = SecureRandom.hex(n=3) // uncomment to use SecureRandom.hex to generate 6 digits of random hex code
#puts driver.manage.window.size  


#def generate_code(number) # This will generate a set of letters to attach to the account name, as a unique identifier
#  charset = Array('A'..'Z') # Array('*'..'*') UPPERCASE A..Z for upper, lowercase for lower, 1..9 for integers
#  Array.new(number) { charset.sample }.join
#end
#key_1 = generate_code(5)
#key_2 = generate_code(5)

#browser = (ENV['browser'] || 'phantomjs').to_sym
#driver = Selenium::WebDriver.for browser#options are chrome, firefox and phantomjs (headless)
#target_size will set the window size for the browser being launched


module SharedVariables
  @browser_width="1280"

  def self.browser_width
    return @browser_width
  end
  
  def self.browser_width=(val)
    @browser_width=val;
  end

  @browser_height="800"

  def self.browser_height
    return @browser_h
  end
  
  def self.browser_height=(val)
    @browser_height=val;
  end

  @username="jeff.shurts@spr.com"

  def self.username
    return @username
  end

  def self.username=(val)
    @username=val;
  end
  
  @password="sfdc6465cubs"

  def self.password
    return @password
  end

  def self.password=(val)
    @password=val;
  end

  @xlspath='TestCase_SalesForce_CreateAccount.xls'

  def self.xlspath
    return @xlspath
  end

  def self.xlspath=(val)
    @xlspath=val;
  end
end
#AfterStep do |scenario|
# confirm = ask("Proceed? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
#exit unless confirm.downcase == 'y'
#end
#@chosen_browser=browser
#  def self.chosen_browser
#     return @chosen_browser

#  def self.chosen_browser=(val)
#    @chosen_browser=val;
#  end



