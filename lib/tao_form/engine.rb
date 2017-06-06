require 'simple_form'
require 'tao_on_rails'
require 'tao_form/inputs'
require 'tao_form/components'

module TaoForm
  class Engine < Rails::Engine
    isolate_namespace TaoForm

    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**', '*.{rb,yml}')]

    paths['app/views'] << 'lib/views'

  end
end
