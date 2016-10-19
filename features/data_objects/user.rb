require 'ffaker'

class User
  attr_accessor :username
  attr_accessor :password

  def initialize
    @username = 'jeff.shurts@spr.com'
    @password = 'sfdc6465cubs'
  end
end
