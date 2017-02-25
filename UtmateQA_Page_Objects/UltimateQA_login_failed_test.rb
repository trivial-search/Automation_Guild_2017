# A simple Ruby test that creates an instance of the UltimateQA.com,
# page object and enters an invalid username/pwd and then asserts on the error message
# To run this test just goto to the folder where this file and page_object class is and
# type "Ruby UltimateQA_login_failed_test.rb "

require './UltimateQA_page.rb'

USERNAME = "sunjeet81@gmail.com"
PASSWORD = "12345"

ultimateqa_page = UltimateQA_page.new
begin
ultimateqa_page.goto_home_url
ultimateqa_page.enter_username(USERNAME)
ultimateqa_page.enter_password(PASSWORD)

#Debt :: instead of the below method I should be instantiating another page object here and validating the existence of that object..
# to confirm that I am indeed logged out
ultimateqa_page.assert_loggedin_failed
ensure
  ultimateqa_page.tear_down
end
