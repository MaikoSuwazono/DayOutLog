require 'capybara/rspec'
require 'selenium-webdriver'
require 'webdrivers'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(
      args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage]
    )
  )
end

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_driver = :selenium_chrome_headless