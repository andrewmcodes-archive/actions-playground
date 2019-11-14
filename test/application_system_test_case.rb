require "test_helper"

if ENV["SELENIUM_HOST"] == "selenium"
  Capybara.javascript_driver = :selenium
  Capybara.run_server = false

  args = ["--no-default-browser-check", "--start-maximized", "--no-sandbox"]
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => args})
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{ENV["SELENIUM_HOST"]}:#{ENV["SELENIUM_PORT"]}/wd/hub",
      desired_capabilities: caps
    )
  end
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
