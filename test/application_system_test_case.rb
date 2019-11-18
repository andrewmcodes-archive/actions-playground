require "test_helper"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w[headless no-sandbox disable-dev-shm-usage disable-gpu enable-features=NetworkService,NetworkServiceInProcess]
    }
  )

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 90

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    url: ENV["SELENIUM_REMOTE_URL"],
    desired_capabilities: capabilities,
    http_client: client
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_chrome
end
