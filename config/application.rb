require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Codingirlsclub
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'
    config.i18n.available_locales = ['zh-CN', 'en']
    config.i18n.fallbacks = true  #当应用程序需要的语言文件缺失时，使用默认的语言文件default_locale  end

    config.action_mailer.default_url_options = { host: 'codingirls.club' }

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile << %w(vendor/assets/*)
    config.assets.precompile << %w(*.png *.jpg *.jpeg *.gif)
  end
end
