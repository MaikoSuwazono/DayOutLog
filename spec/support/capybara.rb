require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new,
    service: Selenium::WebDriver::Service.chrome(path: '/usr/local/bin/chromedriver')
  )
end

Capybara.default_driver = :selenium_chrome
