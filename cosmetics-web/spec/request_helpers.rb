Dir[File.expand_path(File.join(File.dirname(__FILE__), "support", "matchers", "*.rb"))].each do |file|
  require file
end

RSpec.configure do |config|
  config.include Matchers
end
