require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hssb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #

    # タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'

    # config.eager_load_paths << Rails.root.join("extras")

    # rails-i18n
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    # エラー時に空divが自動挿入されるのを防ぐ
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
