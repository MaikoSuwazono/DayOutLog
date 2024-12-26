require 'capybara/rspec'
require 'selenium-webdriver'
require 'webdrivers'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(
      args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage]
    ),
    service: Selenium::WebDriver::Service.chrome(path: '/usr/local/bin/chromedriver')
  )
end

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_driver = :selenium_chrome_headless