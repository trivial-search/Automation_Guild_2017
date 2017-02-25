require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

class UltimateQA_page

  URL = "http://courses.ultimateqa.com/"
  WAIT = Selenium::WebDriver::Wait.new(timeout: 10)
  #Debt :: need to declare constants for other locators as well
  SIGN_IN_BUTTON_ID = "btn-signin"
  LOGON_SUCESS_NOTIFICATION = "#notifications > div > div > div > p.message-text"
  LOGON_NAME_TO_VALIDATE = "sunjeet k"


  def initialize()
    @wd = Selenium::WebDriver.for :firefox
    @wd.manage.window.maximize
  end


  def goto_home_url()
    @wd.get(URL)
  end

  def enter_username(username)

    @wd.find_element(:link_text, "Sign In").click
    WAIT.until {
        @wd.find_element(:id,SIGN_IN_BUTTON_ID).displayed?
      }
    @wd.find_element(:id, "user_email").click
    @wd.find_element(:id, "user_email").clear
    @wd.find_element(:id, "user_email").send_keys username
    @wd.find_element(:id, "user_password").click

  end


  def enter_password(password)
    @wd.find_element(:id, "user_password").clear
    @wd.find_element(:id, "user_password").send_keys password
    @wd.find_element(:id, "btn-signin").click
    WAIT.until {
      !(@wd.find_element(:css,LOGON_SUCESS_NOTIFICATION).displayed?)
  }
  end

  # Debt :: this is different page , so this method should go into another page object
  def assert_loggedin?
    expect(@wd.find_element(:tag_name, "html").text.include? LOGON_NAME_TO_VALIDATE).to eq true
  end


  # Debt :: this is different page , so this method should go into another page object class
  def assert_loggedin_failed
    WAIT.until {
      @wd.find_element(:xpath, "//*[@id='notifications-error']/ul/li").displayed?
    }
    expect(@wd.find_element(:xpath, "//*[@id='notifications-error']/ul/li").displayed?).to eq true
  end

  #Debt :: this is different page , so this method should go into another page object
  def logout()
      @wd.find_element(:xpath, "//a[@id='my_account']/span").click
    WAIT.until {
      @wd.find_element(:xpath, "//div[@id='wrap']/header/div/div[2]/nav/ul[2]/li/ul/li[3]/a").displayed?
    }
      @wd.find_element(:xpath, "//div[@id='wrap']/header/div/div[2]/nav/ul[2]/li/ul/li[3]/a").click
    WAIT.until {
      (@wd.find_element(:css, "#notifications > div > div > div > p.message-text").displayed?)
    }
  end

  #Debt :: this is different page , so this method should go into another page object
  def assert_loggedout?
    expect(@wd.find_element(:xpath, "//*[@id='notifications']/div/div/div/p[1]").displayed?).to eq true
  end


  def tear_down
    @wd.quit
  end

end
