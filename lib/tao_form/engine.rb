require 'simple_form'
require 'tao_on_rails'
require 'tao_ui'

module TaoForm
  class Engine < Rails::Engine

    config.eager_load_paths += Dir["#{config.root}/lib/**/"]

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]

    paths['app/views'] << 'lib/views'

    ::ActiveSupport.on_load :tao_components do
      load_tao_components TaoForm::Engine.root
    end

  end
end
