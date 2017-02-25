# A simple Ruby test that creates an instance of the UltimateQA.com,
# page object and enters a valid username/pwd and then asserts whether i'm logged in or not?
# To run this test just goto to the folder where this file and page_object class is and
# type "Ruby UltimateQA_login_test.rb "

require './UltimateQA_page.rb'

USERNAME = "sunjeet81@gmail.com"
PASSWORD = "yorks64"

ultimateqa_page = UltimateQA_page.new
begin
#ultimateqa_page.initialize_driver
ultimateqa_page.goto_home_url
ultimateqa_page.enter_username(USERNAME)
ultimateqa_page.enter_password(PASSWORD)
ultimateqa_page.assert_loggedin?
ensure
  ultimateqa_page.tear_down
end
