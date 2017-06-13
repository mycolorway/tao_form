require 'simple_form'
require 'tao_form/simple_form_extensions/form_builder'
require 'tao_on_rails'
require 'tao_form/inputs'
require 'tao_form/components'

module TaoForm
  class Engine < Rails::Engine

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]

    paths['app/views'] << 'lib/views'

  end
end
