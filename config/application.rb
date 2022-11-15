require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

config = {
  host: "elasticsearch:9200",
  retry_on_failure: true,
  transport_options: {
    request: { timeout: 250 }
  }
}

# if File.exists?("config/elasticsearch.yml")
#   config.merge!(YAML.load_file("config/elasticsearch.yml")[Rails.env].symbolize_keys)
# end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 5.2

    Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDIS_URL'] }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: ENV['REDIS_URL'] }
    end

    config.active_job.queue_adapter = :sidekiq
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
